declare variable $static external :="/static/doc/";
<div class="container">
      <div class="navbar navbar-inverse" role="navigation">
        <div class="container-fluid">
          
          <div class="navbar-header"> 
            <a class="navbar-brand" href="/doc/">
            <img src="{$static}doc.svg" style="width:20px;height:20px" />
            doc</a>          
          </div>
          
            <ul class="nav navbar-nav" >                
                <li><a href="#/apps"><i class="fa fa-shield"></i> Apps</a></li>
                <li><a href="#/components"><i class="fa fa-comment"></i> Components</a></li>
              
            </ul>
         </div>
        </div>      
        <div class="container">
        <ng-view class="view-animate" style="position:relative;">Loading...</ng-view>
    </div>
</div>

