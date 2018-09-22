From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH] ALSA: usb-audio: Add custom mixer status
 quirks for RME CC devices
Date: Sat, 22 Sep 2018 11:47:58 +0300
Message-ID: <0773db35-269d-1c59-8756-b65c2e34225f@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id D233F267892
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2018 10:48:00 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Please hold applying the patch, I'm having final checks with RME 
regarding the VID or VID:PID based approach when to use this 
functionality. If it seems better to use strict VID:PID table instead, I 
will send an updated patch.


	- Jussi
