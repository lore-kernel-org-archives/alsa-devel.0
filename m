From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/3] ucm: docs: fix doxygen exclude patch
 for UCM local header
Date: Mon, 29 Jun 2015 17:32:21 +0100
Message-ID: <1435595541.2506.11.camel@loki>
References: <1435591559-6277-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5hfv5aecws.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 16E392605CA
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 18:32:25 +0200 (CEST)
In-Reply-To: <s5hfv5aecws.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-06-29 at 17:45 +0200, Takashi Iwai wrote:
> At Mon, 29 Jun 2015 16:25:57 +0100,
> Liam Girdwood wrote:
> > 
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> Thanks, applied all three patches.
> (The next would be to fix doxygen warnings :)

The number is somewhat reduced now that the correct exclude path is used
for ucm :) Most are in PCM now.

Liam
