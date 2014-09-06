declare variable $static external :="/static/doc/";
<div class="container">
      <div class="container-fluid" ng-include="'{$static}templates/navbar.xhtml'">
        </div>
      <div class="center-container">
        <ng-view class="view-animate" style="position:relative;">Loading...</ng-view>
        </div>
    
</div>

