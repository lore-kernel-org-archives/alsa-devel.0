From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: [linux-audio-dev] [Fwd: Re: [linux-audio-user] DSP2000 C-PORT
 and MIDI input]
Date: 26 Apr 2004 07:56:10 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1082984171.3426.1.camel@eviltwin>
References: <408CD917.3070700@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <408CD917.3070700@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lukas,

	I have tons of C programming experience and a little C++.  I also have
a DSP2000 C-Port.  Unfortunately I don't have any MIDI devices or know
anything about MIDI.  Is there anything I can do to help?

Jan


On Mon, 2004-04-26 at 04:40, Lukas Degener wrote:
> Hi everybody and sorry for posting this to both, lad and alsa-dev,
> i was not sure which one fits better.
> 
> Concerning the issue with non-functional midi in on the DSP2000 c-port:
> Someone on lau(Clemens?) said the problem is a lack of information an 
> how to enable some interrupts.
> Matthew Skinner contacted me a couple of days ago (actualy replying to a 
> thread on lau, i think), offereing to provide the missing info + 
> additional help.
> 
> Anyone interested and able to do the required changes should contact 
> him: matt@sound-music.com
> 
> the original "dialog" is attached below. I'm sorry, it is a little 
> cluttered by my mail client :-) hope you can read it anyway.
> 
> Kind Regards,
> Lukas
> 
> 
> ----- Original Message ----- 
> From: "Lukas Degener" <AFBLukas@gmx.de>
> To: "Matthew Skinner, Sound and Music Tech Support" <matt@sound-music.com>
> Sent: Saturday, April 24, 2004 5:50 AM
> Subject: Re: [linux-audio-user] DSP2000 C-PORT and MIDI input
> 
> 
> > Matthew Skinner, Sound and Music Tech Support wrote:
> >
> > > If you can program in c++ and want to get the midi io working on the
> > > cport then let me know what you need.
> >
> > I doubt my programming skills are sufficient to perform ad-hoc
> > modifications on the alsa driver layer, at least not without a
> > exorbitant amount of spare time, which i currently heavily lack :-)
> >
> > As for what is needed/missing: As Clemens said on lau:
> >
> > > Currently, this bug cannot be fixed because nobody knows how to enable
> > > MIDI interrupts on this card.
> >
> > I'm not familiar with driver programming, so i can only vaguely guess,
> > that there is a lack of specifications on certain parts of the c-port
> > hardware.
> > If you can provide this information, i imagine the alsa developers would
> > much apreciate it. It would propably make sense to post your offer on
> > one of their mailing lists.
> >
> > Kind regards,
> > Lukas
> >
> >
> I dont know the best mailinglist to post to or I probably would do so. I can
> provide the missing information and some more help.
> 
> If you want to find someone with the time, knowledge and passion to write
> the extra code for linux then get them to contact myself.
> 
> Regards,
> 
> Matthew Skinner
> Sound and Music Technical Support
> 
> 




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
