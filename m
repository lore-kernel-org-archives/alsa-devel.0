From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Transgaming comments on Alsa for WineX
Date: Sun, 21 Dec 2003 02:24:27 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FE5045B.2090105@superbug.demon.co.uk>
References: <3FE4F76C.2070204@starhub.net.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FE4F76C.2070204@starhub.net.sg>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: R Chan <rspchan@starhub.net.sg>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

R Chan wrote:
> Transgaming have investigated Alsa 1 as a sound option to for WineX.
> 
> http://www.transgaming.com/showthread.php?news=98
> 
> Excerpt
> 
> " ALSA, of particular interest to TransGaming's Linux audience, does not 
> provide
> much of an added benefit over OSS. The primary speed advantage, hardware 
> mixing,
> a slower kludgy implementation use due to the fact that looping sound 
> doesn't appear
> to be supported; although full duplex support should be easier to 
> provide than with OSS.
> The major drawback of ALSA is that its mmap interface is not compatible 
> with what is
> required for DirectSound unless undocumented interfaces are used. All in 
> all it appears
> that using ALSA would provide some speed advantages for newer cards, but 
> to be
> done properly would require a rewrite of the winealsa driver. Thus we 
> would suggest
> that, for the time being, people continue to use the OSS emulation layer of
> ALSA with "MMap" = "Y" enabled in their config file to get the best 
> performance if it's supported on their sound card."
> 
> Apart from mmap which I guess is architectural and quite difficult to 
> change, what about their
> comments on looping sound - useful?
> 
> Cheers
> Richard
> 

I don't think the winex people have much of a clue about how alsa works 
as I a pretty sure all the bad comments about alsa are untrue.




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
