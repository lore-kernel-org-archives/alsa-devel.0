From: Serhiy Kachanuk <serzholino@gmail.com>
Subject: Re: Problems with soundcard based on Realtek ALC860
 audio codec
Date: Thu, 08 Dec 2005 08:02:30 +0200
Message-ID: <4397CC76.9060305@gmail.com>
References: <4396C17D.9060600@gmail.com> <200512070921.38560.rafael.espindola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200512070921.38560.rafael.espindola@gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 07.12.2005 13:21, Rafael =C3=81vila de Esp=C3=ADndola wrote:
>>Is my soundcard supported? What do I need to make my sound system work
>>on Linux?
>=20
> Realtek has an hacked version of alsa. Could you please try:
> http://www.realtek.com.tw/downloads/dlhd-2.aspx?lineid=3D2004052&famid=3D=
2004052&series=3D2004061&Software=3DTrue#2004061Unix=20
> (Linux)
> and report whether it works?

Thank you all guys :)

I've tried realtek version of alsa as long as it is less download then=20
CVS checkout and yes, :) it works! Mixer lacks of master volume, only=20
PCM  and then two front volumes, but sound is working.
I'm now using this card only in stereo mode, is in also possible to use=20
5.1 mode in Linux?

Thank you very much to pointing me to this.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
