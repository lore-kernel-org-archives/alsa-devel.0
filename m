From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/6] ARM: ux500: Remove unused
	snowball_of_platform_devs struct
Date: Tue, 31 Jul 2012 20:58:24 +0000
Message-ID: <201207312058.24640.arnd@arndb.de>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-7-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 571DC265D52
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 22:58:29 +0200 (CEST)
In-Reply-To: <1343741493-17671-7-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 31 July 2012, Lee Jones wrote:
> This was left over during a recent clean-up which removed Device Tree
> helper structs. There is no longer a requirement for it, so we can just
> remove it.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
