From: Gus Zernial <gus_zernial@yahoo.com>
Subject: Via 1708S no S/PDIF out
Date: Sun, 19 Apr 2009 09:33:50 -0700 (PDT)
Message-ID: <781229.19559.qm@web63504.mail.re1.yahoo.com>
Reply-To: gus_zernial@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web63504.mail.re1.yahoo.com (web63504.mail.re1.yahoo.com
	[69.147.97.59]) by alsa0.perex.cz (Postfix) with SMTP id DD968244A0
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Apr 2009 18:33:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I posted this on alsa-user and got no response. I have an ASUS M4A78T-E mot=
herboard system, which has 7.1 channel HD Audio out using Via VT1708S chip,=
 (plus ATI HDMI out). I'm running Kubuntu Jaunty 9.04
with a custom 2.6.28.9 kernel. I am getting sound out the Line
Out/Speaker Out jacks, but no sound through the Toslink S/PDIF Out jack. Th=
e S/PDIF out channel does not show in aplay -L command output, and there is=
 no S/PDIF out slider in amixer.

This is a dual-boot system and everything, including S/PDIF out, works fine=
 with WinXP. In linux, I'm running alsa version 1.0.19. I can post more inf=
ormation if needed, but I think I have the right modules loaded, and I've t=
ried various "model=3D" options for snd_hda_intel, so far none provide S/PD=
IF out.

My questions are .... can someone tell me if S/PDIF out is supposed to work=
 with this audio chip, and if so what do I need to do configuration-wise to=
 get it to work?=A0=A0 Thankyou ...





      =
