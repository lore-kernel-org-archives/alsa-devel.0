From: Kevin Puetz <puetzk@iastate.edu>
Subject: Re: [PATCH] cs46xx some few corrections
Date: Wed, 18 Dec 2002 08:00:50 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212180800.50494.puetzk@iastate.edu>
References: <3DF5A135.4090008@cucumelo.org> <s5hwumh7rth.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwumh7rth.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > Sumary of changes:
> > - Some volume bug fixes
> > - SPDIF input fix.
> > - Clear sample buffer after closing IEC958 stream.
> > - Ring buffer fix (see my previous mail)
> > - Some other misses, corrections ....
>
> applied.  thanks for your patch!

nice, now alsa cvs and the cs46xx are best friends again :-)

Any chance of getting a 2.5 merge sometime soon (since it doesn't seem that 
the current cs46xx builds if dropped into a 2.5 tree)? It sure would be nice 
to have the phase problems fixed there as well.

If there's supposed to be a way to build the alsa cvs against 2.5, that would 
be fine too, but I couldn't figure it out.

> Takashi


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
