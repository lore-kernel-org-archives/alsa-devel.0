From: Karthik Ramgopal <applefreakpeeps@gmail.com>
Subject: Regarding internal mic on Aspire 6935G
Date: Thu, 18 Jun 2009 13:38:52 +0800
Message-ID: <4b8c423b0906172238l36fd4740n62b2f9d9ac8b6cd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by alsa0.perex.cz (Postfix) with ESMTP id 544371037ED
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Jun 2009 07:38:53 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c3so368888ana.2
	for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2009 22:38:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, hector@marcansoft.com
List-Id: alsa-devel@alsa-project.org

Hi,
      Sorry for the confusion. My internal mic does work, but wierdly
not in Gnome Sound recorder. Skype detects it just fine and I am able
to talk without making any changes to the code. So, I guess 8930G and
6935G are same after all.

Thanks and Regards,
Karthik

PS: Please also add the PCI ID's of 6920G (0x1025 0146) and 8920G
(0x1025 0145) under the same quirk. They also use ALC889 chipset with
the same pinconfig.
