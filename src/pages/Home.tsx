import React from 'react';
import { Link } from 'react-router-dom';
import { BarChart2, LineChart, PieChart, TrendingUp } from 'lucide-react';

const Home = () => {
  return (
    <div className="flex flex-col">
      {/* Hero Section */}
      <section className="bg-gradient-to-r from-blue-600 to-green-500 text-white py-20">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center space-y-8">
            <h1 className="text-4xl sm:text-5xl font-bold leading-tight">
              Transform Grades into Insights
            </h1>
            <p className="text-lg sm:text-xl text-blue-100 max-w-2xl mx-auto">
              Visualize your academic journey with powerful analytics and beautiful charts.
              Make informed decisions about your education with CGPAViz.
            </p>
            <div className="flex flex-col sm:flex-row justify-center space-y-4 sm:space-y-0 sm:space-x-4">
              <Link
                to="/features#download"
                className="bg-white text-blue-600 hover:bg-blue-50 px-8 py-3 rounded-lg font-medium text-lg transition-colors duration-200"
              >
                Download Now
              </Link>
              <Link
                to="/features"
                className="border-2 border-white text-white hover:bg-white hover:text-blue-600 px-8 py-3 rounded-lg font-medium text-lg transition-colors duration-200"
              >
                Learn More
              </Link>
            </div>
          </div>
        </div>
      </section>

      {/* Features Preview */}
      <section className="py-20 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-16">
            <h2 className="text-3xl font-bold text-gray-900">
              Why Choose CGPAViz?
            </h2>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {[
              {
                icon: <BarChart2 className="h-8 w-8 text-blue-600" />,
                title: 'Interactive Charts',
                description: 'Visualize your academic progress with dynamic, interactive charts'
              },
              {
                icon: <LineChart className="h-8 w-8 text-green-500" />,
                title: 'Trend Analysis',
                description: 'Track your performance trends across semesters'
              },
              {
                icon: <PieChart className="h-8 w-8 text-blue-600" />,
                title: 'Subject Breakdown',
                description: 'Analyze performance across different subjects'
              },
              {
                icon: <TrendingUp className="h-8 w-8 text-green-500" />,
                title: 'Progress Tracking',
                description: 'Set and monitor academic goals effectively'
              }
            ].map((feature, index) => (
              <div
                key={index}
                className="text-center p-6 rounded-lg hover:shadow-lg transition-shadow duration-200"
              >
                <div className="inline-block p-3 rounded-full bg-gray-50 mb-4">
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

      {/* CTA Section */}
      <section className="bg-gray-50 py-20">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h2 className="text-3xl font-bold text-gray-900 mb-8">
            Ready to Transform Your Academic Journey?
          </h2>
          <Link
            to="/features#download"
            className="inline-block bg-gradient-to-r from-blue-600 to-green-500 text-white px-8 py-3 rounded-lg font-medium text-lg hover:opacity-90 transition-opacity duration-200"
          >
            Get Started Now
          </Link>
        </div>
      </section>
    </div>
  );
};

export default Home;