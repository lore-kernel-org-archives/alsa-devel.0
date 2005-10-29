From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.14: Total lockup using aplaymidi
Date: Sat, 29 Oct 2005 21:08:42 +0100 (BST)
Message-ID: <20051029200842.33920.qmail@web52913.mail.yahoo.com>
References: <1130607006.32367.116.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1130607006.32367.116.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Lee Revell <rlrevell@joe-job.com> wrote:
> OK, great.  This is related to the recent change to make the RTC the
> default timer for the ALSA sequencer, it's not an emu10k1 driver bug.

Which means it affects *every* ALSA user, and not just SB-Live! and Audig=
y owners ... ;-). I guess
people just aren't using aplaymidi on SMP machines much.

Cheers,
Chris



	=09
___________________________________________________________=20
To help you stay safe and secure online, we've developed the all new Yaho=
o! Security Centre. http://uk.security.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
