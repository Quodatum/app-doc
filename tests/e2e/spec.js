describe('doc app tests', function() {

  beforeEach(function() {
    browser.get('http://apps-quodatum.rhcloud.com/doc');
  });
  
  it('should have a title', function() {
    expect(browser.getTitle()).toContain('doc (v');
	
  });
  
   it('should search', function() {
     element(by.model('search.q')).sendKeys("fred");
	 element(by.css("button.btn.btn-default.input-sm")).click();
     expect(browser.getTitle()).toEqual('doc (v0.4.5)');
	
  });
  
  
});