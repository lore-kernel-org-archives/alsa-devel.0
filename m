From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Re: [Alsa-user] Re: Re: SB Live! PCM control
Date: Fri, 11 Feb 2005 21:47:55 +0100
Message-ID: <420D19FB.40603@pobox.sk>
References: <420270C1.3000706@voicenet.com>	 <1107457227.7256.37.camel@krustophenia.net>	 <4202A72C.3000007@superbug.co.uk>	 <1108141670.20188.4.camel@krustophenia.net>	 <420D0112.2050509@superbug.co.uk> <1108153994.20365.39.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108153994.20365.39.camel@krustophenia.net>
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
Cc: James Courtier-Dutton <James@superbug.co.uk>, Adam K Kirchhoff <adamk@voicenet.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Some GPRs are wasted for mute switches. ALSA uses tone controls for all 
channels (kx only for front), ...

Lee Revell wrote:

>There is something gravely wrong with the default SBLive DSP config if
>we don't have enough extra GPRs to implement a master volume.  The kX
>driver does everything we do plus a chorus, reverb, and FX mixer.
>
>Lee
>
>  
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
