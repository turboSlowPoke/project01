<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>Material Design Bootstrap</title>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <!-- Bootstrap core CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <!-- Material Design Bootstrap -->
  <link href="css/mdb.min.css" rel="stylesheet">
  <!-- Your custom styles (optional) -->
  <link href="css/style.min.css" rel="stylesheet"> </head>

<body>
  <!-- Navbar -->
  <nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar">
    <div class="container">
      <!-- Brand -->
      <a class="navbar-brand" target="_blank"> <strong>MDB</strong> </a>
      <!-- Collapse -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
      <!-- Links -->
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <!-- Left -->
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="#">Home <span class="sr-only">(current)</span> </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="https://mdbootstrap.com/material-design-for-bootstrap/" target="_blank">About MDB</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="https://mdbootstrap.com/getting-started/" target="_blank">Free download</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="https://mdbootstrap.com/bootstrap-tutorial/" target="_blank">Free tutorials</a>
          </li>
        </ul>
        <!-- Right -->
        <ul class="navbar-nav nav-flex-icons">
          <li class="nav-item">
            <a href="#" class="nav-link border border-light rounded" target="_blank" data-toggle="modal" data-target="#basicModal"> <i class="fa fa-sign-in"></i>Войти </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <div <div class="modal fade" id="basicModal" tabindex="-1" role="dialog">
      <div class="modal-dialog">
          <div class="modal-content">
              <div class="modal-header">
                  <h4 class="modal-title" id="myModalLabel">Авторизация</h4>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">×</span> </button>
              </div>
              <div class="modal-body">
                  <form>
                      <div class="form-group">
                          <label for="exampleInputLogin">Логин</label>
                          <input type="first_name" class="form-control" id="exampleInputLogin" placeholder="логин">
                      </div>
                      <div class="form-group">
                          <label for="exampleInputPassword1">Пароль</label>
                          <input type="password" class="form-control" id="exampleInputPassword1" placeholder="пароль">
                      </div>
                      <div class="form-check">
                          <input type="checkbox" class="form-check-input" id="exampleCheck1">
                          <label class="form-check-label" for="exampleCheck1">Check me out</label>
                      </div>
                      <button type="submit" class="btn btn-primary">Submit</button>
                      <button class="btn btn-default" type="button" data-dismiss="modal">Закрыть</button>
                  </form>
              </div>
          </div>
      </div>
  </div>
  <!-- Navbar -->
  <!--Carousel Wrapper-->
  <div id="carousel-example-1z" class="carousel slide carousel-fade" data-ride="carousel">
    <!--Indicators-->
    <ol class="carousel-indicators">
      <li data-target="#carousel-example-1z" data-slide-to="0" class="active"></li>
      <li data-target="#carousel-example-1z" data-slide-to="1"></li>
      <li data-target="#carousel-example-1z" data-slide-to="2"></li>
    </ol>
    <!--/.Indicators-->
    <!--Slides-->
    <div class="carousel-inner" role="listbox">
      <!--First slide-->
      <div class="carousel-item active">
        <div class="view" style="background-image: url('https://mdbootstrap.com/img/Photos/Others/nature7.jpg'); background-repeat: no-repeat; background-size: cover;">
          <!-- Mask & flexbox options-->
          <div class="mask rgba-black-light d-flex justify-content-center align-items-center">
            <!-- Content -->
            <div class="text-center white-text mx-5 wow fadeIn">
              <h1 class="mb-4"> <strong>По ТВ не покажут</strong> </h1>
              <p> <strong>бла1 бла1 бла1</strong> </p>
              <p class="mb-4 d-none d-md-block"> <strong>бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2 бла2  </strong> </p>
              <a target="_blank" href="https://mdbootstrap.com/bootstrap-tutorial/" class="btn btn-outline-white btn-lg">Start free tutorial <i class="fa fa-graduation-cap ml-2"></i> </a>
            </div>
            <!-- Content -->
          </div>
          <!-- Mask & flexbox options-->
        </div>
      </div>
      <!--/First slide-->
      <!--Second slide-->
      <div class="carousel-item">
        <div class="view" style="background-image: url('https://mdbootstrap.com/img/Photos/Others/images/77.jpg'); background-repeat: no-repeat; background-size: cover;">
          <!-- Mask & flexbox options-->
          <div class="mask rgba-black-light d-flex justify-content-center align-items-center">
            <!-- Content -->
            <div class="text-center white-text mx-5 wow fadeIn">
              <h1 class="mb-4"> <strong>Learn Bootstrap 4 with MDB</strong> </h1>
              <p> <strong>Best &amp; free guide of responsive web design</strong> </p>
              <p class="mb-4 d-none d-md-block"> <strong>The most comprehensive tutorial for the Bootstrap 4. Loved by over 500 000 users. Video and written versions
                  available. Create your own, stunning website.</strong> </p>
              <a target="_blank" href="https://mdbootstrap.com/bootstrap-tutorial/" class="btn btn-outline-white btn-lg">Start free tutorial <i class="fa fa-graduation-cap ml-2"></i> </a>
            </div>
            <!-- Content -->
          </div>
          <!-- Mask & flexbox options-->
        </div>
      </div>
      <!--/Second slide-->
      <!--Third slide-->
      <div class="carousel-item">
        <div class="view" style="background-image: url('https://mdbootstrap.com/img/Photos/Others/images/47.jpg'); background-repeat: no-repeat; background-size: cover;">
          <!-- Mask & flexbox options-->
          <div class="mask rgba-black-light d-flex justify-content-center align-items-center">
            <!-- Content -->
            <div class="text-center white-text mx-5 wow fadeIn">
              <h1 class="mb-4"> <strong>Learn Bootstrap 4 with MDB</strong> </h1>
              <p> <strong>Best &amp; free guide of responsive web design</strong> </p>
              <p class="mb-4 d-none d-md-block"> <strong>The most comprehensive tutorial for the Bootstrap 4. Loved by over 500 000 users. Video and written versions
                  available. Create your own, stunning website.</strong> </p>
              <a target="_blank" href="https://mdbootstrap.com/bootstrap-tutorial/" class="btn btn-outline-white btn-lg">Start free tutorial <i class="fa fa-graduation-cap ml-2"></i> </a>
            </div>
            <!-- Content -->
          </div>
          <!-- Mask & flexbox options-->
        </div>
      </div>
      <!--/Third slide-->
    </div>
    <!--/.Slides-->
    <!--Controls-->
    <a class="carousel-control-prev" href="#carousel-example-1z" role="button" data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span> </a>
    <a class="carousel-control-next" href="#carousel-example-1z" role="button" data-slide="next"> <span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="sr-only">Next</span> </a>
    <!--/.Controls-->
  </div>
  <!--/.Carousel Wrapper-->

  <!--Main layout-->
  <main>
    <div class="container">
      <!--Section: Main info-->
      <section class="mt-5 wow fadeIn">
        <!--Grid row-->
        <div class="row">
          <!--Grid column-->
          <div class="col-md-6 mb-4">
            <img src="https://mdbootstrap.com/img/Marketing/mdb-press-pack/mdb-main.jpg" class="img-fluid z-depth-1-half" alt=""> </div>
          <!--Grid column-->
          <!--Grid column-->
          <div class="col-md-6 mb-4">
            <!-- Main heading -->
            <h3 class="h3 mb-3">Material Design for Bootstrap</h3>
            <p>This template is created with Material Design for Bootstrap ( <strong>MDB</strong> ) framework.</p>
            <p>Read details below to learn more about MDB.</p>
            <!-- Main heading -->
            <hr>
            <p> <strong>400+</strong> material UI elements, <strong>600+</strong> material icons, <strong>74</strong> CSS animations, SASS files, templates, tutorials and many more. <strong>Free for personal and commercial use.</strong> </p>
            <!-- CTA -->
            <a target="_blank" href="https://mdbootstrap.com/getting-started/" class="btn btn-grey btn-md">Download <i class="fa fa-download ml-1"></i> </a>
            <a target="_blank" href="https://mdbootstrap.com/components/" class="btn btn-grey btn-md">Live demo <i class="fa fa-image ml-1"></i> </a>
          </div>
          <!--Grid column-->
        </div>
        <!--Grid row-->
      </section>
      <hr class="my-5">
      <!--цены-->
      <section>
        <h3 class="h3 text-center mb-5">Услуги</h3>
        <div class="p-5 bg-secondary">
          <div class="container">
            <div class="row">
              <div class="p-3 align-self-center col-md-4">
                <div class="card">
                  <div class="card-block p-5">
                    <h1><sup>$</sup> 25 </h1>
                    <h3>Standard</h3>
                    <hr>
                    <p>Perfect for small business and growing teams.&nbsp;</p>
                    <a href="#" class="btn btn-dark">Subscribe</a>
                  </div>
                </div>
              </div>
              <div class="p-3 align-self-center col-md-4">
                <div class="card">
                  <div class="card-block p-5">
                    <h1><sup>$</sup> 75 </h1>
                    <h3>Premium</h3>
                    <hr>
                    <p>Use all the features and get the maximum out of the app</p>
                    <a href="#" class="btn btn-dark">Subscribe</a>
                  </div>
                </div>
              </div>
              <div class="p-3 align-self-center col-md-4">
                <div class="card">
                  <div class="card-block p-5">
                    <h1><sup>$</sup> 135 </h1>
                    <h3>Pro</h3>
                    <hr>
                    <p>Get the whole pack and forget about everything else</p>
                    <a href="#" class="btn btn-dark">Subscribe</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!--Section: Main info-->
      <hr class="my-5">
      <!--Section: Main features & Quick Start-->
      <section>
        <h3 class="h3 text-center mb-5">About MDB</h3>
        <!--Grid row-->
        <div class="row wow fadeIn">
          <!--Grid column-->
          <div class="col-lg-6 col-md-12 px-4">
            <!--First row-->
            <div class="row">
              <div class="col-1 mr-3"> <i class="fa fa-code fa-2x indigo-text"></i> </div>
              <div class="col-10">
                <h5 class="feature-title">Bootstrap 4</h5>
                <p class="grey-text">Thanks to MDB you can take advantage of all feature of newest Bootstrap 4.</p>
              </div>
            </div>
            <!--/First row-->
            <div style="height:30px"></div>
            <!--Second row-->
            <div class="row">
              <div class="col-1 mr-3"> <i class="fa fa-book fa-2x blue-text"></i> </div>
              <div class="col-10">
                <h5 class="feature-title">Detailed documentation</h5>
                <p class="grey-text">We give you detailed user-friendly documentation at your disposal. It will help you to implement your ideas easily. </p>
              </div>
            </div>
            <!--/Second row-->
            <div style="height:30px"></div>
            <!--Third row-->
            <div class="row">
              <div class="col-1 mr-3"> <i class="fa fa-graduation-cap fa-2x cyan-text"></i> </div>
              <div class="col-10">
                <h5 class="feature-title">Lots of tutorials</h5>
                <p class="grey-text">We care about the development of our users. We have prepared numerous tutorials, which allow you to learn how to use MDB as well as other technologies.</p>
              </div>
            </div>
            <!--/Third row-->
          </div>
          <!--/Grid column-->
          <!--Grid column-->
          <div class="col-lg-6 col-md-12">
            <p class="h5 text-center mb-4">Watch our "5 min Quick Start" tutorial</p>
            <div class="embed-responsive embed-responsive-16by9">
              <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/cXTThxoywNQ" allowfullscreen=""></iframe>
            </div>
          </div>
          <!--/Grid column-->
        </div>
        <!--/Grid row-->
      </section>
      <!--Section: Main features & Quick Start-->
      <hr class="my-5">
      <!--Section: Not enough-->
      <section>
        <h2 class="my-5 h3 text-center">Not enough?</h2>
        <!--First row-->
        <div class="row features-small mb-5 mt-3 wow fadeIn">
          <!--First column-->
          <div class="col-md-4">
            <!--First row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-check-circle fa-2x indigo-text"></i> </div>
              <div class="col-10">
                <h6 class="feature-title">Free for personal and commercial use</h6>
                <p class="grey-text">Our license is user-friendly. Feel free to use MDB for both private as well as commercial projects. </p>
                <div style="height:15px"></div>
              </div>
            </div>
            <!--/First row-->
            <!--Second row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-check-circle fa-2x indigo-text"></i> </div>
              <div class="col-10">
                <h6 class="feature-title">400+ UI elements</h6>
                <p class="grey-text">An impressive collection of flexible components allows you to develop any project. </p>
                <div style="height:15px"></div>
              </div>
            </div>
            <!--/Second row-->
            <!--Third row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-check-circle fa-2x indigo-text"></i> </div>
              <div class="col-10">
                <h6 class="feature-title">600+ icons</h6>
                <p class="grey-text">Hundreds of useful, scalable, vector icons at your disposal.</p>
                <div style="height:15px"></div>
              </div>
            </div>
            <!--/Third row-->
            <!--Fourth row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-check-circle fa-2x indigo-text"></i> </div>
              <div class="col-10">
                <h6 class="feature-title">Fully responsive</h6>
                <p class="grey-text">It doesn't matter whether your project will be displayed on desktop, laptop, tablet or mobile phone. MDB looks great on each screen.</p>
                <div style="height:15px"></div>
              </div>
            </div>
            <!--/Fourth row-->
          </div>
          <!--/First column-->
          <!--Second column-->
          <div class="col-md-4 flex-center">
            <img src="https://mdbootstrap.com/img/Others/screens.png" alt="MDB Magazine Template displayed on iPhone" class="z-depth-0 img-fluid"> </div>
          <!--/Second column-->
          <!--Third column-->
          <div class="col-md-4 mt-2">
            <!--First row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-check-circle fa-2x indigo-text"></i> </div>
              <div class="col-10">
                <h6 class="feature-title">70+ CSS animations</h6>
                <p class="grey-text">Neat and easy to use animations, which will increase the interactivity of your project and delight your visitors. </p>
                <div style="height:15px"></div>
              </div>
            </div>
            <!--/First row-->
            <!--Second row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-check-circle fa-2x indigo-text"></i> </div>
              <div class="col-10">
                <h6 class="feature-title">Plenty of useful templates</h6>
                <p class="grey-text">Need inspiration? Use one of our predefined templates for free.</p>
                <div style="height:15px"></div>
              </div>
            </div>
            <!--/Second row-->
            <!--Third row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-check-circle fa-2x indigo-text"></i> </div>
              <div class="col-10">
                <h6 class="feature-title">Easy installation</h6>
                <p class="grey-text">5 minutes, a few clicks and... done. You will be surprised at how easy it is. </p>
                <div style="height:15px"></div>
              </div>
            </div>
            <!--/Third row-->
            <!--Fourth row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-check-circle fa-2x indigo-text"></i> </div>
              <div class="col-10">
                <h6 class="feature-title">Easy to use and customize</h6>
                <p class="grey-text">Using MDB is straightforward and pleasant. Components flexibility allows you deep customization. You will easily adjust each component to suit your needs.</p>
                <div style="height:15px"></div>
              </div>
            </div>
            <!--/Fourth row-->
          </div>
          <!--/Third column-->
        </div>
        <!--/First row-->
      </section>
      <!--Section: Not enough-->
      <hr class="mb-5">
      <!--Section: More-->
      <section>
        <h2 class="my-5 h3 text-center">...and even more</h2>
        <!--First row-->
        <div class="row features-small mt-5 wow fadeIn">
          <!--Grid column-->
          <div class="col-xl-3 col-lg-6">
            <!--Grid row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-firefox fa-2x mb-1 indigo-text" aria-hidden="true"></i> </div>
              <div class="col-10 mb-2 pl-3">
                <h5 class="feature-title font-bold mb-1">Cross-browser compatibility</h5>
                <p class="grey-text mt-2">Chrome, Firefox, IE, Safari, Opera, Microsoft Edge - MDB loves all browsers; all browsers love MDB. </p>
              </div>
            </div>
            <!--/Grid row-->
          </div>
          <!--/Grid column-->
          <!--Grid column-->
          <div class="col-xl-3 col-lg-6">
            <!--Grid row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-level-up fa-2x mb-1 indigo-text" aria-hidden="true"></i> </div>
              <div class="col-10 mb-2">
                <h5 class="feature-title font-bold mb-1">Frequent updates</h5>
                <p class="grey-text mt-2">MDB becomes better every month. We love the project and enhance as much as possible. </p>
              </div>
            </div>
            <!--/Grid row-->
          </div>
          <!--/Grid column-->
          <!--Grid column-->
          <div class="col-xl-3 col-lg-6">
            <!--Grid row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-comments-o fa-2x mb-1 indigo-text" aria-hidden="true"></i> </div>
              <div class="col-10 mb-2">
                <h5 class="feature-title font-bold mb-1">Active community</h5>
                <p class="grey-text mt-2">Our society grows day by day. Visit our forum and check how it is to be a part of our family. </p>
              </div>
            </div>
            <!--/Grid row-->
          </div>
          <!--/Grid column-->
          <!--Grid column-->
          <div class="col-xl-3 col-lg-6">
            <!--Grid row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-code fa-2x mb-1 indigo-text" aria-hidden="true"></i> </div>
              <div class="col-10 mb-2">
                <h5 class="feature-title font-bold mb-1">jQuery 3.x</h5>
                <p class="grey-text mt-2">MDB is integrated with newest jQuery. Therefore you can use all the latest features which come along with it. </p>
              </div>
            </div>
            <!--/Grid row-->
          </div>
          <!--/Grid column-->
        </div>
        <!--/First row-->
        <!--Second row-->
        <div class="row features-small mt-4 wow fadeIn">
          <!--Grid column-->
          <div class="col-xl-3 col-lg-6">
            <!--Grid row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-cubes fa-2x mb-1 indigo-text" aria-hidden="true"></i> </div>
              <div class="col-10 mb-2">
                <h5 class="feature-title font-bold mb-1">Modularity</h5>
                <p class="grey-text mt-2">Material Design for Bootstrap comes with both, compiled, ready to use libraries including all features as well as modules for CSS (SASS files) and JS.</p>
              </div>
            </div>
            <!--/Grid row-->
          </div>
          <!--/Grid column-->
          <!--Grid column-->
          <div class="col-xl-3 col-lg-6">
            <!--Grid row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-question fa-2x mb-1 indigo-text" aria-hidden="true"></i> </div>
              <div class="col-10 mb-2">
                <h5 class="feature-title font-bold mb-1">Technical support</h5>
                <p class="grey-text mt-2">We care about reliability. If you have any questions - do not hesitate to contact us. </p>
              </div>
            </div>
            <!--/Grid row-->
          </div>
          <!--/Grid column-->
          <!--Grid column-->
          <div class="col-xl-3 col-lg-6">
            <!--Grid row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-th fa-2x mb-1 indigo-text" aria-hidden="true"></i> </div>
              <div class="col-10 mb-2">
                <h5 class="feature-title font-bold mb-1">Flexbox</h5>
                <p class="grey-text mt-2">MDB fully supports Flex Box. You can forget about alignment issues.</p>
              </div>
            </div>
            <!--/Grid row-->
          </div>
          <!--/Grid column-->
          <!--Grid column-->
          <div class="col-xl-3 col-lg-6">
            <!--Grid row-->
            <div class="row">
              <div class="col-2"> <i class="fa fa-file-code-o fa-2x mb-1 indigo-text" aria-hidden="true"></i> </div>
              <div class="col-10 mb-2">
                <h5 class="feature-title font-bold mb-1">SASS files</h5>
                <p class="grey-text mt-2">Arranged and well documented .scss files can't wait until you compile them.</p>
              </div>
            </div>
            <!--/Grid row-->
          </div>
          <!--/Grid column-->
        </div>
        <!--/Second row-->
      </section>
      <!--Section: More-->
    </div>
  </main>
  <!--Main layout-->
  <!--Footer-->
  <footer class="page-footer text-center font-small mt-4 wow fadeIn">
    <!--Call to action-->
    <div class="pt-4">
      <a class="btn btn-outline-white" href="https://mdbootstrap.com/getting-started/" target="_blank" role="button">Download MDB <i class="fa fa-download ml-2"></i> </a>
      <a class="btn btn-outline-white" href="https://mdbootstrap.com/bootstrap-tutorial/" target="_blank" role="button">Start free tutorial <i class="fa fa-graduation-cap ml-2"></i> </a>
    </div>
    <!--/.Call to action-->
    <hr class="my-4">
    <!-- Social icons -->
    <div class="pb-4">
      <a href="https://www.facebook.com/mdbootstrap" target="_blank"> <i class="fa fa-facebook mr-3"></i> </a>
      <a href="https://twitter.com/MDBootstrap" target="_blank"> <i class="fa fa-twitter mr-3"></i> </a>
      <a href="https://www.youtube.com/watch?v=7MUISDJ5ZZ4" target="_blank"> <i class="fa fa-youtube mr-3"></i> </a>
      <a href="https://plus.google.com/u/0/b/107863090883699620484" target="_blank"> <i class="fa fa-google-plus mr-3"></i> </a>
      <a href="https://dribbble.com/mdbootstrap" target="_blank"> <i class="fa fa-dribbble mr-3"></i> </a>
      <a href="https://pinterest.com/mdbootstrap" target="_blank"> <i class="fa fa-pinterest mr-3"></i> </a>
      <a href="https://github.com/mdbootstrap/bootstrap-material-design" target="_blank"> <i class="fa fa-github mr-3"></i> </a>
      <a href="http://codepen.io/mdbootstrap/" target="_blank"> <i class="fa fa-codepen mr-3"></i> </a>
    </div>
    <!-- Social icons -->
    <!--Copyright-->
    <div class="footer-copyright py-3"> © 2018 Copyright:
      <a href="https://mdbootstrap.com/bootstrap-tutorial/" target="_blank"> MDBootstrap.com </a>
    </div>
    <!--/.Copyright-->
  </footer>
  <!--/.Footer-->
  <!-- SCRIPTS -->
  <!-- JQuery -->
  <script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="js/mdb.min.js"></script>
  <!-- Initializations -->
  <script type="text/javascript">
    // Animations initialization
    new WOW().init();
  </script>
  <pingendo onclick="window.open('https://pingendo.com/', '_blank')" style="cursor:pointer;position: fixed;bottom: 10px;right:10px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:180px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">Made with Pingendo&nbsp;&nbsp;
    <img src="https://pingendo.com/site-assets/Pingendo_logo_big.png" class="d-block" alt="Pingendo logo" height="16">
  </pingendo>
</body>

</html>