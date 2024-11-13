import React from 'react';
import { LineChart, BarChart, PieChart, Settings, Download, Share2, Shield } from 'lucide-react';

const Features = () => {
  return (
    <div className="flex flex-col">
      {/* Hero Section */}
      <section className="bg-gradient-to-r from-blue-600 to-green-500 text-white py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h1 className="text-4xl font-bold mb-4">
            Powerful Features for Academic Excellence!
          </h1>
          <p className="text-xl text-blue-100 max-w-2xl mx-auto">
            Discover how CGPAViz can help you visualize and improve your academic performance
          </p>
        </div>
      </section>

      {/* Main Features */}
      <section className="py-16 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-16">
            <div className="space-y-12">
              {[
                {
                  icon: <LineChart className="h-8 w-8 text-blue-600" />,
                  title: "Performance Tracking",
                  description: "Monitor your academic progress with intuitive line charts showing semester-wise CGPA trends."
                },
                {
                  icon: <BarChart className="h-8 w-8 text-green-500" />,
                  title: "Subject Analysis",
                  description: "Compare performance across different subjects with detailed bar charts and statistics."
                },
                {
                  icon: <PieChart className="h-8 w-8 text-blue-600" />,
                  title: "Grade Distribution",
                  description: "Visualize your grade distribution across all courses with interactive pie charts."
                }
              ].map((feature, index) => (
                <div key={index} className="flex space-x-4">
                  <div className="flex-shrink-0">
                    <div className="p-3 bg-gray-50 rounded-lg">
                      {feature.icon}
                    </div>
                  </div>
                  <div>
                    <h3 className="text-xl font-semibold text-gray-900 mb-2">
                      {feature.title}
                    </h3>
                    <p className="text-gray-600">
                      {feature.description}
                    </p>
                  </div>
                </div>
              ))}
            </div>
            
            <div className="bg-gray-100 rounded-lg p-8 flex items-center justify-center">
              <img
                src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=800&q=80"
                alt="CGPAViz Dashboard"
                className="rounded-lg shadow-lg"
              />
            </div>
          </div>
        </div>
      </section>

      {/* Additional Features */}
      <section className="py-16 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <h2 className="text-3xl font-bold text-center text-gray-900 mb-12">
            More Powerful Features
          </h2>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {[
              {
                icon: <Settings className="h-6 w-6" />,
                title: "Customizable Dashboard",
                description: "Personalize your analytics dashboard to focus on what matters most to you."
              },
              {
                icon: <Share2 className="h-6 w-6" />,
                title: "Export & Share",
                description: "Export your visualizations in various formats and share them easily."
              },
              {
                icon: <Shield className="h-6 w-6" />,
                title: "Data Security",
                description: "Your academic data is encrypted and securely stored locally on your device."
              }
            ].map((feature, index) => (
              <div key={index} className="bg-white p-6 rounded-lg shadow-md">
                <div className="text-blue-600 mb-4">
                  {feature.icon}
                </div>
                <h3 className="text-xl font-semibold text-gray-900 mb-2">
                  {feature.title}
                </h3>
                <p className="text-gray-600">
                  {feature.description}
                </p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Download Section */}
      <section id="download" className="py-16 bg-gradient-to-r from-blue-600 to-green-500 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <Download className="h-12 w-12 mx-auto mb-6" />
          <h2 className="text-3xl font-bold mb-4">
            Download CGPAViz Today
          </h2>
          <p className="text-xl text-blue-100 max-w-2xl mx-auto mb-8">
            Available for Windows, macOS, and Linux
          </p>
          <div className="flex flex-col sm:flex-row justify-center space-y-4 sm:space-y-0 sm:space-x-4">
            <button className="bg-white text-blue-600 px-8 py-3 rounded-lg font-medium hover:bg-blue-50 transition-colors duration-200">
              Download for Windows
            </button>
            <button className="bg-white text-blue-600 px-8 py-3 rounded-lg font-medium hover:bg-blue-50 transition-colors duration-200">
              Download for macOS
            </button>
            <button className="bg-white text-blue-600 px-8 py-3 rounded-lg font-medium hover:bg-blue-50 transition-colors duration-200">
              Download for Linux
            </button>
          </div>
        </div>
      </section>
    </div>
  );
};

export default Features;