From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] A few HD-audio things for 3.14
Date: Tue, 26 Nov 2013 09:29:08 +0100
Message-ID: <1385454553-12000-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CCA6B2615EC
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:29:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A20D1A7B62
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:29:26 +0100 (CET)
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

Hi,

here are a few patches that are targeted for 3.14.  So they are not
urgently needed, mostly clean ups, but also includes some runtime PM
changes as we're discussing now.

The patches are found in sound-unstable git tree test/hda branch,
too.


Takashi
