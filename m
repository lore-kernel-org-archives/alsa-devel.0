From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: switch
 disable_power_well default value to 1
Date: Thu, 4 Jul 2013 20:54:44 +0200
Message-ID: <20130704185444.GI18285@phenom.ffwll.local>
References: <1372882333-4011-1-git-send-email-przanoni@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f171.google.com (mail-ea0-f171.google.com
 [209.85.215.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BBF92657B5
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 20:54:44 +0200 (CEST)
Received: by mail-ea0-f171.google.com with SMTP id m14so1018769eaj.30
 for <alsa-devel@alsa-project.org>; Thu, 04 Jul 2013 11:54:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1372882333-4011-1-git-send-email-przanoni@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paulo Zanoni <przanoni@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, Paulo Zanoni <paulo.r.zanoni@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 03, 2013 at 05:12:13PM -0300, Paulo Zanoni wrote:
> From: Paulo Zanoni <paulo.r.zanoni@intel.com>
> 
> Now that the audio driver is using our power well API, everything
> should be working correctly, so let's give it a try.
> 
> Signed-off-by: Paulo Zanoni <paulo.r.zanoni@intel.com>
Picked up for -fixes, thanks for the patch.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
