From: "James H. Cloos Jr." <cloos@jhcloos.com>
Subject: alsa.sf.net
Date: 17 Mar 2002 15:26:58 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3wuwbndnx.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=

Perhaps someone in the alsa group at sf could upload something like
one of the files attached below to:

    alsa.sf.net:/home/groups/a/al/alsa/htdocs/index.php 

so anyone going to alsa.sf.net at least gets redirected to either the
project page at sf or to alsa-project.org....

first redirects to sf.net/projects/alsa.  The 2nd to alsa-project.org.

-JimC


--=-=-=
Content-Type: text/x-php
Content-Disposition: attachment; filename=index.php
Content-Description: Index to redirect to the project page

<?php
// Main index for ALSA project at SourceForge
// Just forward to project page for now
Header("Location: http://sourceforge.net/projects/alsa/");
?>

--=-=-=
Content-Type: text/x-php
Content-Disposition: attachment; filename=index.php
Content-Description: Index to redirect to real homepage

<?php
// Main index for ALSA project at SourceForge
// Just forward to the real homepage
Header("Location: http://alsa-project.org/");
?>

--=-=-=--


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
