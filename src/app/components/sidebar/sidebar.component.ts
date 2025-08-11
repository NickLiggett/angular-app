import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  imports: [CommonModule, RouterOutlet, RouterLink, RouterLinkActive],
  styleUrls: ['./sidebar.component.css']
})
export class SidebarComponent {
  @Input() isOpen = true;
  @Output() closeSidebar = new EventEmitter<void>();

  menuItems = [
    { icon: '🏠', label: 'Dashboard', route: '/dashboard' },
    { icon: '👥', label: 'Users', route: '/users' },
    { icon: '📊', label: 'Analytics', route: '/analytics' },
    { icon: '⚙️', label: 'Settings', route: '/settings' },
    { icon: '📞', label: 'Contact', route: '/contact' }
  ];

  onItemClick() {
    // Close sidebar on mobile when item is clicked
    if (window.innerWidth < 768) {
      this.closeSidebar.emit();
    }
  }
}
