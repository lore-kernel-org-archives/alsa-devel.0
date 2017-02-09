From: Alan Young <Alan.Young@IEE.org>
Subject: Re: [PATCH] pcm: rate: Add capability to pass
 configuration node to plugins
Date: Thu, 9 Feb 2017 15:48:04 +0000
Message-ID: <eb079fb0-f08c-3d27-4a7c-740812ff4337@IEE.org>
References: <bdb7665c-5747-8888-fa2e-552e852fa375@IEE.org>
 <6d7c74b7-da90-5ae9-c355-c6884b2edf09@gmail.com>
 <s5hy3xg8zkp.wl-tiwai@suse.de>
 <7715a537-722a-be54-6635-d92961b0e617@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id F241626680F
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 16:48:05 +0100 (CET)
Received: by mail-wm0-f47.google.com with SMTP id r141so23429217wmg.1
 for <alsa-devel@alsa-project.org>; Thu, 09 Feb 2017 07:48:05 -0800 (PST)
In-Reply-To: <7715a537-722a-be54-6635-d92961b0e617@gmail.com>
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

On 09/02/17 15:41, Alan Young wrote:
> There is no (public) declaration of _snd_pcm_rate_/xxx/_open() 
> function type

Oops, my bad - yes there is.
