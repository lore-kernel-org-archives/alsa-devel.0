From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: More CS4630 improvements, finally multi PCM channel support
Date: Wed, 31 Jul 2002 16:55:55 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020731235555.GA5646@porky>
References: <3D48607D.5020406@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D48607D.5020406@cucumelo.org>; from gorm@cucumelo.org on Wed, Jul 31, 2002 at 15:11:09 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.07.31 15:11 Benny Sjostrand wrote:
> Hi!
> 
> I've implemented multi PCM channel support for cs46xx based soundcards, 
> the PCM multichannel  should work on any soundcard

    The surprises just don't stop coming!

[...]
> That's it, ending up here, the aditional feutures should be:
> - PCM multichannel.
> - Secondary CODEC, ALSA mixer, front && rear output (same output from 
> rear && front).
> - SPDIF output. (i believe that i need some more help from Cirrus and 
> maybe Hercules and other card manufacturers to get  SPDIF input working)


    Currently, SPDIF and rear-out is not functional on the Santa Cruz. But
multichannel PCM works great!
    I'm waiting for Turtle Beach to respond to a request for Santa Cruz
documentation. If this fails, I will try to contact Videologic for some 
docs
on the Sonic Fury, the same card with a different name. Hopefully they will
provide some information that will help getting SPDIF and rear-out working.


Thanks Benny,

-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
