From: John Rigg <j@sound-man.co.uk>
Subject: Re: Real-world reports on two Delta 1010LTs/ice1712 synched?
Date: Sun, 18 Dec 2005 22:25:43 +0000
Message-ID: <20051218222543.GA4450@localhost.localdomain>
References: <43A5C630.7000704@findus.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <jackit-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <43A5C630.7000704@findus.dhs.org>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Petter =?iso-8859-1?Q?Sundl=F6f?= <petter.sundlof@findus.dhs.org>
Cc: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 18, 2005 at 09:27:28PM +0100, Petter Sundl=F6f wrote:
> Hello.
>=20
> I have the chance to buy a second M-Audio Delta 1010LT (ice1712 chip)=20
> for approximately US$ 60. I've browsed through the mailing lists, and I=
=20
> couldn't find any definite practical/real-world results saying that=20
> synching two cards (via a BNC cable through the world clock connectors?=
)=20
> worked without problems.

There are a few things to be aware of. After it took me 2 months to get
two Delta 1010s working I put up a web page about it at

http://www.sound-man.co.uk/linuxaudio/ice1712multi.html

The info there might save you some trouble.
I'm using a (short) BNC cable made with a piece of TV co-ax to sync the
two boxes. It works. (OK the 1010 has the BNCs on the breakout box
instead of a flying lead like the 1010LT, but I don't expect that to
make a difference).
BTW the manual I got with my Delta 1010s says the word clock input will o=
nly
take up to 50kHz. I've been told by M-Audio tech support that this is a t=
ypo
and it will take the full 96kHz.

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
