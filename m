From: Chris Rankin <rankincj@yahoo.com>
Subject: All Capture devices missing from CVS alsamixer?
Date: Mon, 20 Sep 2004 09:03:36 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040920080336.42863.qmail@web52905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

As the subject line says, I have noticed that all the
"PCM Capture", "MIC Capture", "AC97 Capture" etc
devices have vanished from my alsamixer application. I
am using the current CVS alsa-driver, alsa-lib and
alsa-utils, and have checked on both a SB-Live! and a
SB-Audigy2 card.

The biggest problem this caused me was that it became
extremely difficult to resolve a microphone feedback
problem that I was having in GnomeMeeting, especially
since it was being caused by the "PCM Capture"
setting.

Is this anything to do with the alsa-lib being
1.0.7-rc1 but the alsa-utils still being 1.0.6?

Thanks for any insights here,
Cheers,
Chris



	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun!  http://uk.messenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
