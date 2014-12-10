From: Lars-Peter Clausen <lars@metafoo.de>
Subject: About SNDRV_PCM_HW_PARAM_TICK_TIME
Date: Wed, 10 Dec 2014 15:49:40 +0100
Message-ID: <54885D84.90003@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-210.synserver.de (smtp-out-212.synserver.de
 [212.40.185.212])
 by alsa0.perex.cz (Postfix) with ESMTP id 55A0226054F
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 15:49:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linux-ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Hi,

I was trying to figure out what exactly SNDRV_PCM_HW_PARAM_TICK_TIME does, 
but couldn't find too much.

Is it safe to say that nowadays this is unused and deprecated and the only 
reason it is kept around is for ABI reasons?

Thanks,
- Lars
