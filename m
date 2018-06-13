From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH 0/1] ALSA: usb-audio: Remove explicitly listed
	Mytek devices
Date: Wed, 13 Jun 2018 09:08:54 +0300
Message-ID: <1528870135-30669-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 10CCD266E76
 for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2018 08:09:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I missed the part that removes Mytek devices from explicit list, from the
earlier patch set when merging changes from my kernel tree.

This patch removes the devices already covered by the earlier patch
which also covers the Mytek Liberty DAC not listed here.
