From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: Cirrus Logic S/PDIF
Date: Tue, 21 May 2002 08:41:16 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020521154116.GA1031@porky>
References: <20020517152415.GA872@porky> <s5helg5hj6w.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5helg5hj6w.wl@alsa2.suse.de>; from tiwai@suse.de on Tue, May 21, 2002 at 03:46:47 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.05.21 03:46 Takashi Iwai wrote:
> the attached patch is what you mentioned above?
> if it's ok, then i'll commit it to cvs.

    Yes. I just patched it into the latest CVS, and it worked
perfectly. 
>>    I have not checked, but I assume this would also apply to other
>>  Cirrus Logic AC'97 codecs?
> 
> well, we need to check spec sheets to be sure.
> could you tell us which chips did you check (to be supposed to work)?

    I only have two CS4297A based cards, so that's all I've tried so
far. I'll check the specs on the other Cirrus chips as soon as possible,
but will need someone else to test them.


-- Peter Heatwole
"Murphy was just a well known pessimist."


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
