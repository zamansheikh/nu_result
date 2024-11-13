import React from 'react';
import { Shield, Lock, Eye, Database } from 'lucide-react';

const Privacy = () => {
  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <div className="text-center mb-12">
        <h1 className="text-3xl font-bold text-gray-900 mb-4">Privacy Policy</h1>
        <p className="text-gray-600">
          Your privacy is important to us. This policy outlines how we handle your data.
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
        {[
          {
            icon: <Shield className="h-8 w-8 text-blue-600" />,
            title: "Data Protection",
            description: "Your academic data is stored locally on your device and never transmitted to our servers."
          },
          {
            icon: <Lock className="h-8 w-8 text-green-500" />,
            title: "Security",
            description: "We implement industry-standard security measures to protect your information."
          },
          {
            icon: <Eye className="h-8 w-8 text-blue-600" />,
            title: "Transparency",
            description: "We're clear about what data we collect and how we use it."
          },
          {
            icon: <Database className="h-8 w-8 text-green-500" />,
            title: "Local Storage",
            description: "All your CGPA data is stored locally and remains under your control."
          }
        ].map((item, index) => (
          <div key={index} className="bg-white p-6 rounded-lg shadow-md">
            <div className="mb-4">
              {item.icon}
            </div>
            <h3 className="text-xl font-semibold text-gray-900 mb-2">
              {item.title}
            </h3>
            <p className="text-gray-600">
              {item.description}
            </p>
          </div>
        ))}
      </div>

      <div className="prose prose-blue max-w-none">
        <section className="mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-4">Information We Collect</h2>
          <p className="text-gray-600 mb-4">
            CGPAViz collects the following information:
          </p>
          <ul className="list-disc pl-6 text-gray-600 mb-4">
            <li>Academic records and grades (stored locally)</li>
            <li>App usage statistics for improvement purposes</li>
            <li>Crash reports to enhance stability</li>
          </ul>
        </section>

        <section className="mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-4">How We Use Your Information</h2>
          <p className="text-gray-600 mb-4">
            We use the collected information for:
          </p>
          <ul className="list-disc pl-6 text-gray-600 mb-4">
            <li>Providing CGPA visualization and analysis</li>
            <li>Improving app performance and features</li>
            <li>Technical support and troubleshooting</li>
          </ul>
        </section>

        <section className="mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-4">Data Storage and Security</h2>
          <p className="text-gray-600 mb-4">
            All academic data is stored locally on your device. We implement appropriate security
            measures to protect against unauthorized access, alteration, disclosure, or destruction
            of your information.
          </p>
        </section>

        <section className="mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-4">Your Rights</h2>
          <p className="text-gray-600 mb-4">
            You have the right to:
          </p>
          <ul className="list-disc pl-6 text-gray-600 mb-4">
            <li>Access your personal data</li>
            <li>Delete your data from the application</li>
            <li>Export your data in common formats</li>
            <li>Opt-out of anonymous usage statistics</li>
          </ul>
        </section>

        <section>
          <h2 className="text-2xl font-semibold text-gray-900 mb-4">Contact Us</h2>
          <p className="text-gray-600">
            If you have any questions about this Privacy Policy, please contact us through our
            contact page or email us at privacy@cgpaviz.com
          </p>
        </section>
      </div>
    </div>
  );
};

export default Privacy;