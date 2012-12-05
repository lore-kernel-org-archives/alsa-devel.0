From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/3] ALSA: ASoC: McASP: determine XSSZ
	value programatically
Date: Wed, 05 Dec 2012 18:18:04 +0100
Message-ID: <50BF81CC.2030008@gmail.com>
References: <1354721862-10318-1-git-send-email-zonque@gmail.com>
 <1354721862-10318-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id AD075261694
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 18:18:10 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so2184947bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 05 Dec 2012 09:18:10 -0800 (PST)
In-Reply-To: <1354721862-10318-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: mporter@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, vaibhav.bedia@ti.com, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org

On 05.12.2012 16:37, Daniel Mack wrote:
> This shouldn't change any functionality and is just a preparation a
> special case handling.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Hold on - I found another way that even does more cleanups. I'll
resubmit a v2.


Daniel
