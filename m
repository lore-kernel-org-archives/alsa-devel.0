From: rob buse <rcbuse@filter24.org>
Subject: rtc timer and linux 2.6(3.0 ?)
Date: Mon, 21 Oct 2002 14:00:45 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210211800.g9LI0jG18697@mole.e-mol.com>
Reply-To: rcbuse@filter24.org
Content-Type: text
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


I have a quick question.  Im not exactly sure of the internals of ALSA and 
how it deals with timers, other than I am running with the rtc timer kernel 
patch for the sequencer.  My question is, when the new kernel comes out with 
the high-res timer support (http://sourceforge.net/projects/high-res-timers), 
will it be nessessary to patch the kernel for RTC (like 2.4), or will alsa 
start using the new kernel timers, or does it already do this with 2.5 ?

thanks!
.rob

_______________________________________________________
Sent through e-mol. E-mail, Anywhere, Anytime. http://www.e-mol.com





-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future of 
Java(TM) technology. Join the Java Community Process(SM) (JCP(SM)) 
program now. http://ad.doubleclick.net/clk;4699841;7576298;k?
http://www.sun.com/javavote
