package mctt;

import org.junit.Test;

import mctt.preprocessing._
import mctt.statemachine._
import mctt.emitter.qml._
import mctt.emitter.scxml._
import mctt._

import java.io.File

class SMBuilderTester {

  /*
   * Simple tests
   */
	@Test
	def test1() {
    val mctt = "enabling(any_mw_md(I_selectPizza), enabling(any_mw_md(I_confirmSelection), any_mw(A_cookPizza)))"
    val path = new File("src/test/resources/test1/")
    Translator.translate(mctt, path, path, true, false, true)
	}
  
  @Test
  def test2() {
    val mctt = "any_mw_md(enabling(I_pressstart, enabling(A_timercountdown, any_md(A_finishingalarm))))"
    val path = new File("src/test/resources/test2/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def test3() {
    val mctt = "any_mw_md(enabling(I_selectpizza, enabling(I_confirm, enabling(A_defrost, A_cook))))"
    val path = new File("src/test/resources/test3/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def test4() {
    val mctt = "any_mw(enabling(I_pressstart, enabling(A_timercountdown, any_md(A_finishingalarm))))"
    val path = new File("src/test/resources/test4/")
    Translator.translate(mctt, path, path, true, false, true)
  }

  @Test
  def test5() {
    val mctt = "enabling(any_mw_md(enabling(I_sethour, I_setmin)), enabling(any_mw(I_setsec), any_md(I_confirm)))"
    val path = new File("src/test/resources/test5/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  /*
   * More complex tests (combinations of ALL and ANY)
   */
  @Test
  def test6(){
    val mctt = "choice(any_mw_md(enabling(I_selectPizza, enabling(I_confirmPizzaSelection, any_mw(enabling(A_defrost, A_cook))))),enabling(any_mw_md(I_selectCookingMode), enabling(any_mw_md(I_setPower), all_mw_md(A_showConfig))))"
    val path = new File("src/test/resources/test6/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def test7(){
    val mctt = "choice(any_mw_md(enabling(I_selectPizza, enabling(I_confirmPizzaSelection, any_mw(enabling(A_defrost, A_cook))))),any_mw(enabling(I_selectCookingMode, enabling(I_setPower, all_mw_md(A_showConfig)))))"
    val path = new File("src/test/resources/test7/")
    val mapping = new File("src/test/resources/mapping.txt")
    Translator.translate(mctt, path, mapping, true, true, true)
  }
  
  @Test
  def test8(){
    val mctt = "choice(any_mw_md(enabling(I_selectPizza, enabling(I_confirmPizzaSelection, any_mw(enabling(A_defrost, A_cook))))),enabling(all_mw_md(enabling(I_selectCookingMode, I_setPower)), any_md(A_showConfig)))"
    val path = new File("src/test/resources/test8/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def test9(){
    val mctt = "choice(any_mw_md(enabling(I_selectPizza, enabling(I_confirmPizzaSelection, any_mw(enabling(A_defrost, A_cook))))),all_mw_md(enabling(I_selectCookingMode, enabling(any_md(I_setPower), A_showConfig))))"
    val path = new File("src/test/resources/test9/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def test10(){
    val mctt = "any_md_mw(disabling(enabling(I_setHour, enabling(I_setMinute, enabling(I_setSeconds, I_confirmTime))), enabling(I_resetTime, I_confirm)))"
    val path = new File("src/test/resources/test10/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def test11(){
    val mctt = "any_mw_md(enabling(I_selectPizza, enabling(any_md(enabling(A_showPizzaImage, any_mw(I_confirmSelection))), any_mw(enabling(A_defrost, A_cook)))))"
    val path = new File("src/test/resources/test11/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def test12(){
    val mctt = "all_mw_md(enabling(I_setCooking, enabling(I_setPower, any_md(A_showConfig))))"
    val path = new File("src/test/resources/test12/")
    Translator.translate(mctt, path, path, true, false, true)
  }

  @Test
  def test13(){
    val mctt = "all_mw_md(enabling(I_setCooking, enabling(any_md(I_setPower), A_showConfig)))"
    val path = new File("src/test/resources/test13/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def test14(){
    val mctt = "any_mw_md_mc(enabling(I_selectPizza, enabling(any_md(enabling(A_showPizzaImage, any_mw_md(I_confirmSelection))), any_mw(enabling(A_defrost, A_cook)))))"
    val path = new File("src/test/resources/test14/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def test15(){
    val mctt = "any_md_mc(enabling(I_setCooking, enabling(I_setPower, all_mw_md(A_showConfig))))"
    val path = new File("src/test/resources/test15/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def test16(){
    val mctt = "any_md_mw(disabling(enabling(I_setHour, enabling(I_setMinute, enabling(I_setSeconds, I_confirmTime))), enabling(I_resetTime, I_confirm)))"
    val path = new File("src/test/resources/test16/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def test17() {
    val mctt = "any_mw(enabling(I_pressstart, enabling(A_timercountdown, enabling(any_md(A_finishingalarm), any_mw_md(I_confirmalaram)))))"
    val path = new File("src/test/resources/test17/")
    Translator.translate(mctt, path, path, true, false, true)
  }

  @Test
  def test18() {
    val mctt = "any_mw_md(enabling(I_pressstart, enabling(A_timercountdown, A_finishingalarm)))"
    val path = new File("src/test/resources/test18/")
    Translator.translate(mctt, path, path, true, false, true)
  }

  @Test
  def test19() {
    val mctt = "any_mw_md(enabling(I_pressstart, enabling(A_timercountdown, I_confirmalarm)))"
    val path = new File("src/test/resources/test19/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  /*
   * Tests for Concurrent-Operator
   */
  @Test
  def test20() {
    val mctt = "any_md(concurrent(enabling(I_enterAddress, A_openAddress), enabling(I_volumeUp, I_volumeDown)))"
    val path = new File("src/test/resources/test20/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  /*
   * Any in All
   */
  @Test
  def test21(){
    val mctt = "all_mw_md(enabling(I_setCooking, enabling(I_setPower, any_md(enabling(A_showConfig, A_executeConfig)))))"
    val path = new File("src/test/resources/test21/")
    Translator.translate(mctt, path, path, true, false, true)
  }
  
  @Test
  def mappingTest(){
    val settings = MappingParser.load(new File("src/test/resources/mapping.txt"))
    print(settings)
  }
}
