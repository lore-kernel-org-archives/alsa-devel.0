From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Support for Audigy2 Value SB0400
Date: Mon, 22 Nov 2004 18:28:38 +0000
Message-ID: <41A22FD6.8030103@superbug.co.uk>
References: <419FF760.8050200@superbug.co.uk> <s5hd5y6dnds.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5y6dnds.wl@alsa2.suse.de>
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
> At Sun, 21 Nov 2004 02:03:12 +0000,
> James Courtier-Dutton wrote:
> 
>>The following URL contains a patch against the current alsa-driver CVS.
>>It addes support for the SB0400 version of the Audigy2 Value, that uses 
>>the new CA0108 chip.
>>
>>http://www.alsa-project.org/~james/alsa-driver/audigy2/audigy2_value-support.diff
> 
> 
> May I assume that the function of Audigy2-value is identical with
> Audigy2?  (since you set the driver name "Audigy2" for Audigy2
> Value.)
> 
> The patch looks fine.  Could you provide the nice patch description
> and the signed-off-by lines?
> 
> 
> thanks,
> 
> Takashi
> 
> 

The patch makes the Audigy2 Value work exectly the same as the Audigy2 
currently works.

patch description:
This adds support for the SB0400 version of the Audigy2 Value, that uses 
the new CA0108 chip.

Signed-off-by: James Courtier-Dutton



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
