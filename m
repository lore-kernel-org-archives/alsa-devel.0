From: Rimas Kudelis <rq@akl.lt>
Subject: Re: More detailed Acer (Intel HDA)
Date: Wed, 22 Mar 2006 12:55:55 +0200
Message-ID: <44212D3B.2010203@akl.lt>
References: <200603220041.k2M0f8uA011967@auster.physics.adelaide.edu.au>	 <1142988679.4532.197.camel@mindpipe>  <4420FB3E.3030804@akl.lt>	 <1143012964.1792.61.camel@mindpipe>  <44210F4D.8070508@akl.lt> <1143020228.1792.63.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1257; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1143020228.1792.63.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi,

>> OTOH, I just remembered I know one guy who has windows (hopefully,
>> XP) 
>> on a similar notebook. Maybe he'll test it, if I catch him online.
>> What 
>> app should he use for that? 
>>     
> I don't know, anything that lets you play CDs in analog mode.
>   
I just talked to him and asked him to test CD playback using Microsoft's 
FlexiCD tray utility (distributed along with Windows 95 Powertoys 
package [1]; I've also put the FlexiCD binary to [2]). The results 
surprise me - it seems like analog CD playback indeed works on Windows. 
Or maybe it's just Windows XP pretending to do analog playback while 
actually playing digitally?

[1] 
http://www.microsoft.com/windows95/downloads/contents/WUToys/W95PwrToysSet/Default.asp
[2] http://jazz.lmta.lt/~rq/pub/flexicd.exe

If you insist, the CD control widgets may be left in the mixer, but I 
can't send a corrected patch today. Can someone else do that? However, I 
really doubt that in the current state it would work for anyone.

Rimas




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
