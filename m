From: Chip Salzenberg <chip@pobox.com>
Subject: "Missing, Reward Offered: /proc/asound/dev"
Date: Fri, 16 May 2003 16:50:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030516205018.GI7921@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OK, I'm in the habit of playing with the CVS drivers, and of course
when it breaks it's my own fault, and that's fine ... but:

Today I see in CVS that the "/proc/asound/dev" directory is not just
temporarily broken; its support has been entirely removed.  Now none
of my alsa apps (well, OK, I only have two) are happy, nor do they
have any prospect of being happy in the future.

Can I get a "WTF?" from the congregation?!  Amen!
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
