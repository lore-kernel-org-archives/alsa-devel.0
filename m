From: Harald Gutmann <harald.gutmann@gmx.net>
Subject: Re: joining 2 mixer ports with .asoundrc?
Date: Mon, 04 Sep 2006 13:48:55 +0200
Message-ID: <44FC12A7.2050007@gmx.net>
References: <44F8348E.2040200@gmx.net>	<20060901174734.GA2629@localhost.localdomain>	<s5hfyfbmr4g.wl%tiwai@suse.de>	<44F8CB9E.8070108@gmx.net>
	<s5hmz9gkjtj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmz9gkjtj.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb:
> At Sat, 02 Sep 2006 02:09:02 +0200,
> Harald Gutmann wrote:
>   
>>> Right.  But apart from that, a combined mixer is actually an
>>> interesting topic.
>>>
>>> Unfortunately, there is no framework for the combined mixer elements
>>> (unlike PCM) right now.  In theory, this could be implemented via
>>> alsa-lib mixer plugin.
>>>   
>>>       
>> is it planned to add such a framework for combining mixers per .asoundrc?
>> i think it would be a good idea to add a similar framework like it's 
>> used to
>> route audio in the .asoundrc.
>>     
>
> No plan, no time :-<
>
> Feel free to implement it by yourself...
>   
i'd like to do it, but i don't have the knowladge to code.
i'm only a poor user ;).

but fine to know, that it isn't possible at the moment, i don't have to 
invest time in searching. :)

harald

>
> Takashi
>
>
>   


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
