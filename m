From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Fixes AC3 output on Audigy2 sound cards.
Date: Wed, 23 Mar 2005 20:46:35 +0000
Message-ID: <4241D5AB.7050604@superbug.co.uk>
References: <423C312E.7010503@superbug.co.uk>	<s5hacow4w4b.wl@alsa2.suse.de>	<423F3C05.3010100@superbug.co.uk> <s5hzmwv1jnx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hzmwv1jnx.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>>
>>
>>Patch must be applied after the "[PATCH] Add framework for better audigy 
>>sound card capabilities selection." one.
>>
>>
>>Signoff: James Courtier-Dutton
>>
>>This patch adds a DSP patch to fix an spdif_bug on some Audigy2 cards.
> 
> 
> OK, it's on CVS now.  Thanks.
> 
> 
> Takashi
> 
> 

Takashi,

Did you also apply the patch to the Audigy2.conf file, that goes with 
this patch? The spdif out routing has changed.


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
