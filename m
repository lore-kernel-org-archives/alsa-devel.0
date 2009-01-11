From: Andrea Borgia <andrea@borgia.bo.it>
Subject: Re: [PATCH - SB-0500 1/1] preliminary support for
	Toshiba SB-0500
Date: Sun, 11 Jan 2009 03:20:00 +0100
Message-ID: <49695750.3020802@borgia.bo.it>
References: <s5h3afuivsl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vsmtp12.tin.it (vsmtp12.tin.it [212.216.176.206])
	by alsa0.perex.cz (Postfix) with ESMTP id DCF511037EB
	for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2009 03:20:01 +0100 (CET)
In-Reply-To: <s5h3afuivsl.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Thanks, applied now on next/usb-audio branch on sound-2.6.git tree.

Any idea of which kernel will that go into? 29, 30?

By the way, currently this device shows up in /proc/asound with a rather
dull name, i.e. "Device". Where should I look for changing it to a more
informative value?

Andrea.
