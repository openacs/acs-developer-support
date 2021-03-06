
<property name="context">{/doc/acs-developer-support {Developer Support}} {Developer Support}</property>
<property name="doc(title)">Developer Support</property>
<master>

<body>
<h2>Developer Support</h2>
part of the <a href="">ArsDigita Community System</a>, by <a href="mailto:jsalz@mit.edu">Jon Salz</a><ul>
<li>Admin interface: /www/admin/monitoring/request-info.tcl</li><li>Procedures: /packages/developer-support-procs.tcl, with support
in:
<ul>
<li>/tcl/ad-abstract-url.tcl</li><li>/tcl/ad-defs.tcl.preload</li><li>/tcl/ad-security.tcl.preload</li>
</ul>
</li>
</ul><h3>The Big Picture</h3>
Software development is a big feedback loop: a developer writes
something, tests it, and then repeats until the results are
satisfactory. It's important to streamline this cycle by having a
development environment which makes it easy to analyze what the
software is doing under the hood.
<h3>Peeking Under the Hood</h3><p>Our development environment previously consisted largely of
Emacs, and <tt>tail -f
/web/servername/log/servername-error.log</tt>. Now this has been
augmented: <tt>ad_footer</tt> and <tt>ad_admin_footer</tt> now
display a link entitled <i>Developer Information</i>. (You can use
the <tt>ds_link</tt> procedure to generate the link yourself.)
Following the link displays a screenful of information
including:</p><ul>
<li>The times that the request started and ended, and its duration
(with millisecond accuracy).</li><li>The request parameters (method, url, query, headers,
etc.).</li><li>The output headers, if any.</li><li>Information about all database queries performed while loading
the page, including their respective durations (with millisecond
accuracy).</li>
</ul><p>In addition, the ClientDebug facility of AOLserver 2 has been
re-implemented in the abstract URL system (which serves nearly all
non-static pages). If an error occurs while serving a page, a stack
trace is printed out.</p><p>Note that these nifty features pop up only when you are logged
in as a site-wide administrator! Revealing this information to
anyone else would pose a huge security risk.</p><h3>Comments</h3>
Tired of using <tt>ns_log</tt> to instrument your code, then
grokking the error log to see what's wrong with your page? Use the
<tt>ds_comment</tt> routine instead:
<blockquote><pre>
ds_comment "Foo is $foo"
</pre></blockquote>
Your comment will show up at the bottom of the page, beneath the
<i>Developer Information</i> link (but only for site-wide
administrators). It will also be displayed on the Developer
Information page itself.
<p>Comments are displayed even if an error occurs in the page!</p><h3>Enabling It</h3>
Add the following to your <tt>parameters/yourservername.ini</tt>
file:
<blockquote><pre>
[ns/server/yourservername/acs/developer-support]
; remember information about connections, for developers' benefit?
EnabledP=1
; remember information about every database request?
DatabaseEnabledP=1
; remember information for which client hosts?
EnabledIPs=*
; remember this information for how long? sweep how often? (in seconds)
DataLifetime=900
DataSweepInterval=900
</pre></blockquote>
Note that you may not want to enable this stuff for production
systems - they probably incur a slight performance hit (although
this hasn't been benchmarked).
<h3>How It Works</h3>
The security subsystem registers preauth and trace filters which
store relevant connection information in shared variables
(<tt>nsv</tt>s). The security subsystem also renames the AOLserver
<tt>ns_db</tt> procedure and registers a wrapper which aggregates
information about database queries.
<hr><address><a href="mailto:jsalz@mit.edu">jsalz@mit.edu</a></address><p>Last Modified: $Id: index.html,v 1.1.1.1 2001/04/20 20:51:09
donb Exp $</p>
</body>
