From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: Updating www.alsa-project.org?
Date: Fri, 8 Feb 2002 16:42:03 +0200
Message-ID: <20020208144208Z38455-696+7957@nic.funet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello. I found out that the current www.alsa-project.org pages
are not as good as they should be. They are next to nothing
for non-developers (such as vendors) who yet don't know what
Alsa is. Information is in wrong importantness order, and there
actually is not a clear explanation what is the Alsa. A good page
don't start with a ChangeLog of sorts!

I don't want write all the changes we need to do for the
webpages. I even cannot do that because I don't have php3
system. So, would somebody copy existing pages to the temporary
directory "www.alsa-project.org/new/" where we all together will
incrementally rewrite the web pages? Thanks.

My suggestions are following:

The main page would contain the contents table (on left) and should
describe (on right) clearly what is the Alsa project and what are
the contact addresses. Don't expect people to join the mailing lists
for contacting purposes. No other information.

I would rearrange the content table as shown here; the most important
information would come first.
  Press
  Vendor Call
  Search
  News
  Soundcards
  Download
  Documentation
  Mailing-Lists
  Bug Reporting  (perhaps should be elsewhere)
  Applications
  Links

I deleted the "new API" because it goes to Documentation
page. I'm also considering Development page which would contain
the devel materials. It looks like the devel material is now
distributed around the webpages.

If Development page would be added it would contain CVS source
access, documentation for non-user API, devel mailing list info,
bug reporting, ChangeLog of sorts, and link to SourceForge
(which is now badly hidden under the main title (should be removed
 from there)).

The vertical align of the contents table should be changed:
  valign="middle"  -->  valign="top"
Then readers have greater changes to access the other pages
without the use of the scrollbar everytime.

I have not yet written the texts for the main page (or the other
pages) but if this rewriting gets started, I will continue.

Suggestions? ...and I don't want to hear the webpage is good
enough now. It is worst of the kind --- think about vendors
who are looking if Alsa is good enough for them.

Best regards,

Juhana

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
