From: Richard Smith <smithbone@gmail.com>
Subject: Re: Status of M-Audio Audiophile USB
Date: Wed, 26 Oct 2005 16:13:58 -0500
Message-ID: <8a0c36780510261413j2d5673a2tff4603dd59020648@mail.gmail.com>
References: <8a0c36780510261216x387ca9c0ib9e51f64e319852a@mail.gmail.com>
	 <1130357854.4483.125.camel@mindpipe>
	 <8a0c36780510261403w1487a429kbc5d530a2e21d8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <8a0c36780510261403w1487a429kbc5d530a2e21d8f@mail.gmail.com>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Oops.  I sent this direct rather than to the list.

On 10/26/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Wed, 2005-10-26 at 14:16 -0500, Richard Smith wrote:
> > What I haven't made work is recording.  Using arecord and hw:0,0 just
> > gives silence and hw:0,1 white noise.
>
> What about arecord with plughw:0,0 and plughw:0,1?

Hmm not sure.  I was actually testing with -t raw and  -f S24_3BE so
thats why I was using hw.

I'll try the plughw tonight.  What format should I use?  It seemed to
be very picky about the format or I just got an error.

--
Richard A. Smith


--
Richard A. Smith


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
