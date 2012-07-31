From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 3/6] ARM: ux500: Fix merge error, so such struct 'snd_soc_u8500'
Date: Tue, 31 Jul 2012 20:46:46 +0400
Message-ID: <50180BF6.6080908@mvista.com>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org> <1343741493-17671-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343741493-17671-6-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hello.

On 07/31/2012 05:31 PM, Lee Jones wrote:

  Subject doesn't parse for me...

> The platform attempts to register platform device 'snd_soc_u8500'
> which doesn't actually exist. Here we change the reference to the
> correct one 'snd_soc_mop500'.

> Signed-off-by: Lee Jones <lee.jones@linaro.org>

WBR, Sergei
