;(function() { var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};(function() {



}).call(this);
templates['filelist'] = template(function (Handlebars,depth0,helpers,partials,data) {
  helpers = helpers || Handlebars.helpers;
  var stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n<tr>\n	<td><i class=\"icon-";
  stack1 = depth0.isDir;
  stack1 = helpers['if'].call(depth0, stack1, {hash:{},inverse:self.program(4, program4, data),fn:self.program(2, program2, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\"></i></td>\n	<td><a ";
  stack1 = depth0.isDir;
  stack1 = helpers['if'].call(depth0, stack1, {hash:{},inverse:self.noop,fn:self.program(6, program6, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += " href=\"";
  stack1 = depth0.isDir;
  stack1 = helpers['if'].call(depth0, stack1, {hash:{},inverse:self.program(10, program10, data),fn:self.program(8, program8, data)});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\">";
  stack1 = depth0.file;
  stack1 = typeof stack1 === functionType ? stack1() : stack1;
  buffer += escapeExpression(stack1) + "</a></td>\n	<td>";
  stack1 = depth0.size;
  stack1 = typeof stack1 === functionType ? stack1() : stack1;
  buffer += escapeExpression(stack1) + "</td>\n</tr>\n";
  return buffer;}
function program2(depth0,data) {
  
  
  return "folder-close";}

function program4(depth0,data) {
  
  
  return "file";}

function program6(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "class=\"dir\" data-path=\"";
  stack1 = depth0.fullname;
  stack1 = typeof stack1 === functionType ? stack1() : stack1;
  buffer += escapeExpression(stack1) + "\"";
  return buffer;}

function program8(depth0,data) {
  
  
  return "#";}

function program10(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "/download";
  stack1 = depth0.fullname;
  stack1 = typeof stack1 === functionType ? stack1() : stack1;
  buffer += escapeExpression(stack1);
  return buffer;}

  stack1 = depth0.files;
  stack1 = helpers.each.call(depth0, stack1, {hash:{},inverse:self.noop,fn:self.program(1, program1, data)});
  if(stack1 || stack1 === 0) { return stack1; }
  else { return ''; }});
})();