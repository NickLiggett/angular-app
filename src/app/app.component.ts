import { Component } from '@angular/core';
import { HeaderComponent } from './components/header/header.component'
import { SidebarComponent } from './components/sidebar/sidebar.component';
import { MainContentComponent } from './components/main-content/main-content.component';

@Component({
  selector: 'app-root',
  imports: [HeaderComponent, SidebarComponent, MainContentComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class App {
  title = 'my-angular-app';
  isSidebarOpen = true;

  toggleSidebar() {
    this.isSidebarOpen = !this.isSidebarOpen;
  }
}
