From: "Ryan Cassidy" <rcassidy@stanford.edu>
Subject: One drop-out per xrun?
Date: Wed, 10 Dec 2003 15:17:20 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000601c3bf73$c2cbb460$264440ab@roboserv1>
Reply-To: <rcassidy@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello all,

I wanted to check my knowledge of something: does an xrun necessarily
correspond to a "drop-out" in the audio stream?  In other words, could
you have a drop-out WITHOUT an xrun, or an xrun WITHOUT a drop-out?  Is
there a strict one-to-one correspondence between the two?

Any assistance, as always, GREATLY appreciated.

Cheers, rjc.
--
Ryan Cassidy
Electrical Engineering Graduate Student, CCRMA Researcher
Stanford University
E-mail: ryanc@ieee.org
 




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
