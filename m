From: "Ma Begaj" <derliebegott@gmail.com>
Subject: Asus M2NPV-VM snd_hda_intel problem - also with Alsa
	1.0.15rc3
Date: Fri, 28 Sep 2007 21:29:54 +0200
Message-ID: <a72d33330709281229v1144cf03r31db37581ccb9a49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 86F0E10381D
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Sep 2007 21:29:55 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so4140506wag
	for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2007 12:29:54 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

for the sweet love of ... does anyone have an idea how to make this
sound chip working...


I have Asus M2NPV-VM with AD1986A sound chip. I tried "model=3stack
position_fix=1", but it does not help.

surround does not work and sound mutes whenever I change volume.

when I use model=ultra or eapd-laptop, stereo is at stable and I can
change volume. but surround


I tried it with vanilla kernel 2.6.21.5/26.22.6 and snd_hda_intel from
the kernel without any success. I even compiled Alsa 1.0.15rc3, but
situation did no change.


anybody ... with any idea ... I would appreciate any help. any help at all.

thanks.

M.
