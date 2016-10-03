/*******************************************************************************
* Copyright (c) 2016 Andreas Wagner.
* All rights reserved. This program and the accompanying materials
* are made available under the terms of the Eclipse Public License v1.0
* which accompanies this distribution, and is available at
* http://www.eclipse.org/legal/epl-v10.html
* 
* Contributors:
*     Andreas Wagner - Concept and implementation
*     Christian Prehofer - Concept
*******************************************************************************/
package mctt.preprocessing

import mctt.All
import mctt.Any
import mctt.Choice
import mctt.Disabling
import mctt.Reset
import mctt.Repeat
import mctt.Enabling
import mctt.Concurrent
import mctt.Expr
import mctt.Task
import mctt.TaskType
import mctt.AnnotatedTask

/**
 * Collect all distinct labels in the task tree.
 */
object LabelCollector {
  def collect(tree: Expr): Set[String] = tree match {
    case Any(e1: Expr, labels: List[String]) => { labels.toSet.union(collect(e1)) }
    case All(e1: Expr, labels: List[String]) => { labels.toSet.union(collect(e1)) }
    case Enabling(e1: Expr, e2: Expr)        => { collect(e1).union(collect(e2)) }
    case Disabling(e1: Expr, e2: Expr)       => { collect(e1).union(collect(e2)) }
    case Reset(e1: Expr, e2: Expr)           => { collect(e1).union(collect(e2)) }
    case Repeat(e1: Expr)                    => { collect(e1) }
    case Concurrent(e1: Expr, e2: Expr)      => { collect(e1).union(collect(e2)) }
    case Choice(e1: Expr, e2: Expr)          => { collect(e1).union(collect(e2)) }
    case Task(ttype: TaskType.Value, name: String)  => { Set() }
  }
}

/**
 * Annotate each task with corresponding labels.
 * Labels indicate, whether tasks may run concurrently or isolated.
 * Note: This function should be executed per label!
 */
object LabelAnnotator {
  def annotate(tree: Expr, currLabel: String, labels: Set[String], definedLabels: Set[String]): (Expr, Map[Task, AnnotatedTask]) = tree match {
    case Any(e1: Task, lblset: List[String]) => { 
      val (any, map) = annotate(e1, currLabel, lblset.toSet, lblset.toSet)
      (Any(any, lblset), map)
    }
    /*
    //TODO: Clarify semantics! (see tests 10 and 16)
    case Any(Disabling(e1: Expr, e2: Expr), lblset: List[String]) => {
      val (left, leftMap) = annotate(Any(e1, Set(currLabel).intersect(lblset.toSet).toList), currLabel, Set(currLabel).intersect(lblset.toSet), lblset.toSet)
      val (right, rightMap) = annotate(Any(e2, Set(currLabel).intersect(lblset.toSet).toList), currLabel, Set(currLabel).intersect(lblset.toSet), lblset.toSet)
      (Any(Disabling(left,right), lblset), leftMap ++ rightMap)
    }
    * 
    */
    case Any(Any(e1: Expr, lblset: List[String]), lblset_outer: List[String]) => { 
      val (any, map) = annotate(e1, currLabel, Set(currLabel).intersect(lblset.toSet), lblset.toSet)
      (Any(any, lblset), map) 
    }
    case Any(All(e1: Expr, lblset: List[String]), lblset_outer: List[String]) => { 
      val (all, map) = annotate(e1, currLabel, lblset.toSet, lblset.toSet)
      (All(all, lblset), map) 
    }
    case Any(e1: Expr, lblset: List[String])                                  => { 
      val (any, map) = annotate(e1, currLabel, Set(currLabel).intersect(lblset.toSet), lblset.toSet)
      (Any(any, lblset), map) 
    }
    case All(All(e1: Expr, lblset: List[String]), lblset_outer: List[String]) => { 
      val (all, map) = annotate(e1, currLabel, lblset.toSet, lblset.toSet)
      (All(all, lblset), map)
    }
    case All(Any(e1: Expr, lblset: List[String]), lblset_outer: List[String]) => { 
      val (any, map) = annotate(e1, currLabel, Set(currLabel).intersect(lblset.toSet), lblset.toSet) 
      (Any(any, lblset), map)
    }
    /*
    //TODO: also clarify semantics!
    case All(Disabling(e1: Expr, e2: Expr), lblset: List[String]) => {
      val (left, leftMap) = annotate(All(e1, Set(currLabel).intersect(lblset.toSet).toList), currLabel, lblset.toSet, lblset.toSet)
      val (right, rightMap) = annotate(All(e2, lblset), currLabel, lblset.toSet, lblset.toSet)
      (Disabling(left, right), leftMap ++ rightMap)
    }
    * 
    */
    case All(e1: Expr, lblset: List[String]) => { 
      val (expr, map) = annotate(e1, currLabel, lblset.toSet, lblset.toSet) 
      (All(expr, lblset), map) 
    }
    case Enabling(e1: Expr, e2: Expr)        => { 
      val (left, leftMap) = annotate(e1, currLabel, labels, definedLabels)
      val (right, rightMap) = annotate(e2, currLabel, labels, definedLabels)
      (Enabling(left, right), leftMap ++ rightMap)
    }
    case Disabling(e1: Expr, e2: Expr)       => { 
      val (left, leftMap) = annotate(e1, currLabel, labels, definedLabels)
      val (right, rightMap) = annotate(e2, currLabel, labels, definedLabels)
      (Disabling(left, right), leftMap ++ rightMap) 
    }
    case Reset(e1: Expr, e2: Expr)       => { 
      val (left, leftMap) = annotate(e1, currLabel, labels, definedLabels)
      val (right, rightMap) = annotate(e2, currLabel, labels, definedLabels)
      (Reset(left, right), leftMap ++ rightMap) 
    }
    case Repeat(e1: Expr)       => { 
      val (left, leftMap) = annotate(e1, currLabel, labels, definedLabels)
      (Repeat(left), leftMap) 
    }
    case Choice(e1: Expr, e2: Expr)          => { 
      val (left, leftMap) = annotate(e1, currLabel, labels, definedLabels)
      val (right, rightMap) = annotate(e2, currLabel, labels, definedLabels)
      (Choice(left, right), leftMap ++ rightMap) 
    }
    case Concurrent(e1: Expr, e2: Expr)          => { 
      val (left, leftMap) = annotate(e1, currLabel, labels, definedLabels)
      val (right, rightMap) = annotate(e2, currLabel, labels, definedLabels)
      (Concurrent(left, right), leftMap ++ rightMap) 
    }
    case Task(t: TaskType.Value, s: String) => {
      if(definedLabels == labels){ // Any(task)
        val activeLabelTuples = for(l <- definedLabels) yield {
          (l, labels)
        }
        val task = AnnotatedTask(t, s, Map(activeLabelTuples.toSeq:_*), definedLabels)
        (task, Map((tree.asInstanceOf[Task], task)))
      }
      else{ // Any(expr)
        val activeLabelTuples = for(l <- definedLabels) yield {
          (l, Set(l))
        }
        val task = AnnotatedTask(t, s, Map(activeLabelTuples.toSeq:_*), definedLabels)
        (task, Map((tree.asInstanceOf[Task], task)))
      }
    }
  }
}

/**
 * Annotate each task with information by what other task it is activated.
 * Useful when generating state machines for ANY.
 * Note: This function should be executed on the original tree!
 */
object ActivatedByAnnotator {
  def annotate(tree: Expr): (Set[Task], Set[Task], Set[Task]) = tree match {
    case Any(e1: Expr, lblset: List[String]) => {
      var (first, all, last) = annotate(e1)
      (first, all, last)
    }
    case All(e1: Expr, lblset: List[String]) => {
      var (first, all, last) = annotate(e1)
      (first, all, last)
    }
    case Enabling(e1: Expr, e2: Expr) => {
      var (first_l, all_l, last_l) = annotate(e1)
      var (first_r, all_r, last_r) = annotate(e2)
      first_r.foreach { _.activatedBy = last_l.toSeq }
      (first_l, all_l union all_r, last_r)
    }
    case Disabling(e1: Expr, e2: Expr) => {
      var (first_l, all_l, last_l) = annotate(e1)
      var (first_r, all_r, last_r) = annotate(e2)
      //first_r.foreach { _.activatedBy = all_l.toSeq }
      (first_l, all_l union all_r, last_r union last_l)
    }
    case Reset(e1: Expr, e2: Expr) => {
      var (first_l, all_l, last_l) = annotate(e1)
      var (first_r, all_r, last_r) = annotate(e2)
      //first_r.foreach { _.activatedBy = all_l.toSeq }
      (first_l, all_l union all_r, last_l)
    }
    case Repeat(e1: Expr) => {
      var (first, all, last) = annotate(e1)
      (first, all, last)
    }
    case Choice(e1: Expr, e2: Expr) => {
      var (first_l, all_l, last_l) = annotate(e1)
      var (first_r, all_r, last_r) = annotate(e2)
      (first_l union first_r, all_l union all_r, last_l union last_r)
    }
    case Concurrent(e1: Expr, e2: Expr) => {
      var (first_l, all_l, last_l) = annotate(e1)
      var (first_r, all_r, last_r) = annotate(e2)
      (first_l union first_r, all_l union all_r, last_l union last_r)
    }
    case Task(ttype: TaskType.Value, name: String) => {
      (Set(tree.asInstanceOf[Task]), Set(tree.asInstanceOf[Task]), Set(tree.asInstanceOf[Task]))
    }
  }
}

