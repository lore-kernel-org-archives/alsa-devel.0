From: Tom Watson <sdc695@yahoo.com>
Subject: Compile problems (not really??)
Date: Thu, 8 Jan 2004 18:11:20 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040109021120.58166.qmail@web60804.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

It looks like the compile problems mentioned in earlier messages are
mostly due to the fact that I hadn't installed any of the driver/lib
stuff.  This could impact the includes needed by both alsa-oss, and
alsa-utils.  Something changed between 0.9.6 (what I had installed) and
1.0.1 (what I was compiling).

Oh, well.  Good intensions gone bad.  Looks like one needs to
compile/install parts, not compile parts, then install parts.

Live & learn.  (*SIGH*)

=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
