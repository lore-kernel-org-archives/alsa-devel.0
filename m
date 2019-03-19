From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Mar 19 (sound/soc/codecs/nau8810.c)
Date: Tue, 19 Mar 2019 07:13:57 -0700
Message-ID: <00f5cef0-4024-caf2-7f98-52b1e92b13b2@infradead.org>
References: <20190319161236.214675f6@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319161236.214675f6@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Lin <ctlin0@nuvoton.com>, moderated for non-subscribers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 3/18/19 10:12 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190318:
> 

on i386:

ld: sound/soc/codecs/nau8810.o: in function `nau8810_set_pll':
nau8810.c:(.text+0x6e7): undefined reference to `__udivdi3'


-- 
~Randy
