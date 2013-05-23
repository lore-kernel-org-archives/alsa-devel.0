From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] cs42l52: microphone bias is controlled
 by IFACE_CTL2 register.
Date: Thu, 23 May 2013 15:25:37 +0200
Message-ID: <519E18D1.8050601@metafoo.de>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
 <1369243167-28700-3-git-send-email-nschichan@freebox.fr>
 <20130522183850.GX1627@sirena.org.uk> <519E128C.1020509@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-099.synserver.de (smtp-out-100.synserver.de
 [212.40.185.100])
 by alsa0.perex.cz (Postfix) with ESMTP id BACA5261A20
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 15:25:48 +0200 (CEST)
In-Reply-To: <519E128C.1020509@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On 05/23/2013 02:58 PM, Nicolas Schichan wrote:
> On 05/22/2013 08:38 PM, Mark Brown wrote:
>> On Wed, May 22, 2013 at 07:19:25PM +0200, Nicolas Schichan wrote:
>>>
>>> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
>>
>> Applied, but please always CC maintainers on patches and use changelogs
>> appropriate for the subsystem.
> 
> Hi,
> 
> I Cc'ed only the maintainers reported by get_maintainers.pl (you are
> reported as 'supporter'), but I'll note to Cc you next time, sorry about that.

A supporter is actually the more advanced version of a maintainer ;)

>From MAINTAINERS:
       Supported:   Someone is actually paid to look after this.
       Maintained:  Someone actually looks after it.

- Lars
