function Paint(canvas) {
    this.canvas = canvas;
    this.context = null;
    var previousX, previousY, isMouseDown;
	var lineRange,isMouseDownRange = false;
	var colorButtonRed,colorButtonBlue,colorButtonGreen;
	var eraser_l,eraser_m,eraser_s;
}

Paint.prototype = {
//实现画笔功能
    inlay: function () {
        this.context = this.canvas.getContext("2d");
		var font = '黑体';
		var fontSize = 100;
		this.context.font = fontSize + 'px' +' '+ font;
        this.context.lineWidth = 5;
        this.context.lineCap = "round";
        var paint = this;
        this.context.strokeStyle = "blue";
        
        this.canvas.addEventListener("mousedown",function(event){
        paint.isMouseDown = true;
        paint.previousX = event.clientX + document.body.scrollLeft - paint.canvas.offsetLeft;
        paint.previousY = event.clientY + document.body.scrollTop - paint.canvas.offsetTop;
		//paint.context.fillText('你妈的',paint.previousX,paint.previousY,400);
        });
        
        this.canvas.addEventListener("mouseup",function(event){
        paint.isMouseDown = false;
        });

        this.canvas.addEventListener("mousemove",function(event){
        if(paint.isMouseDown){
            var x = event.clientX + document.body.scrollLeft - paint.canvas.offsetLeft;
            var y = event.clientY + document.body.scrollTop - paint.canvas.offsetTop;
        paint.context.beginPath();
        paint.context.moveTo(paint.previousX,paint.previousY);
        paint.context.lineTo(x,y);
        paint.context.stroke();
        paint.previousX = x;
        paint.previousY = y;
        }       
    });
	
	//选择画笔粗细
     this.lineRange = document.getElementById("lineRange");
	 this.lineRange.addEventListener("mousedown",function(){
	 paint.isMouseDownRange = true;
	 });
	 this.lineRange.addEventListener("mouseup",function(){
	 if(paint.isMouseDownRange  == true){
	 paint.context.lineWidth = paint.lineRange.value;
	 paint.isMouseDownRange = false;
	 }
	 });

//选择画笔颜色
	this.colorButtonRed = document.getElementById("colorButtonRed");
	this.colorButtonRed.addEventListener("mousedown",function(){
	 paint.context.lineWidth = paint.lineRange.value;
	 paint.context.strokeStyle = paint.colorButtonRed.name;
	 });

	this.colorButtonBlue = document.getElementById("colorButtonBlue");
	this.colorButtonBlue.addEventListener("mousedown",function(){
	 paint.context.lineWidth = paint.lineRange.value;
	 paint.context.strokeStyle = paint.colorButtonBlue.name;
	 });
	 
	this.colorButtonGreen = document.getElementById("colorButtonGreen");
	this.colorButtonGreen.addEventListener("mousedown",function(){
	 paint.context.lineWidth = paint.lineRange.value;
	 paint.context.strokeStyle = paint.colorButtonGreen.name;
	 });

	 //选择橡皮擦
	this.eraser_l = document.getElementById("eraser_l");
	this.eraser_l.addEventListener("mousedown",function(){
	 paint.context.strokeStyle = "white";
	 paint.context.lineWidth = 20;
	 paint.contxet.lineCap = "square";
	 });
	 
	this.eraser_m = document.getElementById("eraser_m");
	this.eraser_m.addEventListener("mousedown",function(){
	 paint.context.strokeStyle = "white";
	 paint.context.lineWidth = 15;
	 paint.contxet.lineCap = "square";
	 });
	 
	this.eraser_s = document.getElementById("eraser_s");
	this.eraser_s.addEventListener("mousedown",function(){
	 paint.context.strokeStyle = "white";
	 paint.context.lineWidth = 10;
	 paint.contxet.lineCap = "square";
	 });
}
};