From: william estrada <MrUmunhum@popdial.com>
Subject: resetting an audio device?
Date: Wed, 19 Sep 2007 17:05:22 -0700
Message-ID: <46F1B942.8000102@popdial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 63C76245DA
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 02:05:13 +0200 (CEST)
Received: from laptop.mt-umunhum-wireless.net (64.124.13.3.gatespeed.com
	[64.124.13.3]) by MAIL02.inside.adbasesystems.com
	(Vircom SMTPRS 4.4.568.54) with ESMTP id
	<B0398131896@MAIL02.inside.adbasesystems.com> for
	<alsa-devel@alsa-project.org>; Wed, 19 Sep 2007 20:05:09 -0400
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

Hi guys,

   I got my alsa player code to work.  Now I need to figure out how to
reset the audio device?  I don't want to close the device, just recycle
it. Any pointers?

   Also, where are the documents for all of those helper subroutes? Like
snd_pcm_hw_params_get_period_time, snd_pcm_hw_params_any, etc.

   Thanks for your time.

-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum
