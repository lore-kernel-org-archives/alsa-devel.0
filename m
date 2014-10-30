From: Takashi Iwai <tiwai@suse.de>
Subject: [ALSA 0/8] Yet more documentation updates
Date: Thu, 30 Oct 2014 16:06:13 +0100
Message-ID: <1414681581-4619-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A1EF26060C
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:06:23 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 82577ACF4
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 15:06:23 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here are more updates of patches to complete kerneldoc comments.
At this time, HD-audio generic parser, control PCM and core stuff are
covered.  Also, ASoC files are included in alsa-driver-api documents
now.

 [PATCH 1/8] ALSA: hda - Add kerneldoc comments to hda_generic.c
 [PATCH 2/8] ALSA: doc: Add ASoC codes into API documentation
 [PATCH 3/8] ALSA: control: Add missing kerneldoc comments to exported
 [PATCH 4/8] ALSA: pcm: Use static inline for
 [PATCH 5/8] ALSA: pcm: More kerneldoc updates
 [PATCH 6/8] ALSA: pcm: Convert params_*() with static inline
 [PATCH 7/8] ALSA: doc: More kerneldoc comments on core components
 [PATCH 8/8] ALSA: doc: Fix missing "I" for kerneldoc inclusion


Takashi
