import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { BarChart2 } from 'lucide-react';

const Navbar = () => {
  const location = useLocation();
  
  const isActive = (path: string) => location.pathname === path;
  
  return (
    <nav className="bg-gradient-to-r from-blue-600 to-green-500 text-white shadow-lg">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          <Link to="/" className="flex items-center space-x-2">
            <BarChart2 className="h-8 w-8" />
            <span className="font-bold text-xl">CGPAViz</span>
          </Link>
          
          <div className="hidden md:flex space-x-8">
            {[
              { path: '/', label: 'Home' },
              { path: '/features', label: 'Features' },
              { path: '/contributors', label: 'Contributors' },
              { path: '/contact', label: 'Contact' }
            ].map(({ path, label }) => (
              <Link
                key={path}
                to={path}
                className={`${
                  isActive(path)
                    ? 'text-white font-semibold'
                    : 'text-blue-100 hover:text-white'
                } transition-colors duration-200`}
              >
                {label}
              </Link>
            ))}
          </div>
          
          <div className="hidden md:flex space-x-4">
            <Link
              to="/features#download"
              className="bg-white text-blue-600 hover:bg-blue-50 px-4 py-2 rounded-lg font-medium transition-colors duration-200"
            >
              Download App
            </Link>
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;