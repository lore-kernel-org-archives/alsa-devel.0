From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Mon, 16 Jun 2003 17:46:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EEDE673.3070003@folkwang-hochschule.de>
References: <Pine.LNX.4.44.0306161315300.11284-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306161315300.11284-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 16 Jun 2003, Jaroslav Kysela wrote:
>=20
>=20
>>>thanks for the clarification. i'd be glad to help, but i doubt i could=
=20
>>>meet the coding standards of alsa-lib. at least i could help test it.
>>>do you or anyone of the alsa core developers have plans to tackle this=
=20
>>>some time soon ? i'd love to be able to use my controller box for the =

>>>LinuxTag presentations in mid-July.
>>
>>I am working on it right now, but it requires to add new states to=20
>>sequencer event encoder...
>=20
>=20
> Initial code is in CVS. It is not tested, but hopefully, without any ma=
jor=20
> bugs. It seems that we have also missing encoding of CONTROL14 events.
>=20
> 						Jaroslav

shit. anon cvs seems to be lagging behind. do you happen to have a patch =

? otherwise it will probably be another day before i can test it...





--=20
All Members shall refrain in their international relations from
the threat or use of force against the territorial integrity or
political independence of any state, or in any other manner
inconsistent with the Purposes of the United Nations.
	-- Charter of the United Nations, Article 2.4


J=F6rn Nettingsmeier
Kurf=FCrstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)







-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
