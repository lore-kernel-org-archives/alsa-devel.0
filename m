From: Martin Langer <martin-langer@gmx.de>
Subject: Tascam USx2x Audio (was: usbus428 0.0.7 patch against release alsa-driver 0.9.6)
Date: Sun, 31 Aug 2003 10:39:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030831083954.GA921@tuba.home>
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
To: annabellesgarden@yahoo.de, us428@drehmoment.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 20, 2003 at 08:29:12PM +0200, Karsten Wiese wrote:

> would you try the us428 audio part on the us122? 

Yes, I've tried it out and capturing runs perfect. Playback is ok if you do it
not longer than 5 seconds or so. Then speed becomes slower and sloooweeer
and it sounds terrible croaky from there on. I guess that's the sync problem
you mentioned.

But I believe we should try a common USx2x approach. (BTW: I've used
your latest patch as base for my experiments, not 007).


bye,
martin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
