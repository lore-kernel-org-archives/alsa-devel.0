From: Will <walsac2@liam2.demon.co.uk>
Subject: Re: [PATCH] add aplaymidi & arecordmidi utils
Date: Tue, 24 Feb 2004 17:51:41 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402241751.RAA03643@liam2.demon.co.uk>
References: <Pine.HPX.4.33n.0402241834400.5168-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402241834400.5168-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <clemens@ladisch.de> wrote:
>>
>>  I'm getting empty MIDI files containing only the MIDI header.
>
>Are you using the latest CVS version of ALSA?
>Some of the bugfixes I sent yesterday are needed by arecordmidi.
>

No, but I applied your patches to alsa-lib-1.0.3rc1 and Linux 2.6.3 in
include/sound/asequencer, sound/* etc.  Is that enough to get a
working ALSA sequencer?

Will



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
